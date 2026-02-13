import asyncio
import sys
from typing import Final

from loguru import logger
from telegram import Update
from telegram.ext import Application, ApplicationBuilder, CommandHandler, ContextTypes

from config import settings


def configure_logging() -> None:
    logger.remove()
    logger.add(
        sys.stdout,
        format="<green>{time:YYYY-MM-DD HH:mm:ss}</green> | "
        "<level>{level: <8}</level> | "
        "<cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - "
        "<level>{message}</level>",
        backtrace=True,
        diagnose=True,
    )


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    user_first_name: str | None = update.effective_user.first_name if update.effective_user else None
    logger.info("Received /start from user={}", user_first_name)
    await update.message.reply_text("👋 AI template bot is up and running.")


async def build_application() -> Application:
    token: Final[str] = settings.telegram_token
    app: Application = (
        ApplicationBuilder()
        .token(token)
        .build()
    )

    app.add_handler(CommandHandler("start", start))
    return app


async def main() -> None:
    configure_logging()
    logger.info("Starting AI template bot in environment={}", settings.environment)

    application: Application = await build_application()

    try:
        await application.initialize()
        await application.start()
        logger.info("Bot started. Waiting for updates...")
        await application.updater.start_polling()
        await application.updater.wait_for_stop()
    finally:
        logger.info("Shutting down bot...")
        await application.stop()
        await application.shutdown()


if __name__ == "__main__":
    asyncio.run(main())

