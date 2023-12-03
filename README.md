# Habitat

This is a little telegram bot that reminds me to sleep on time. It's written in Ruby.

## Installation

To install and run Habitat, follow these steps:

1. **Install Dependencies:** Habitat uses Bundler for managing Ruby dependencies. Run the following command in the project directory to install the required gems:
 ```bash
 bundle install
 ```

 (if you're don't want to use bundler) See the `Gemfile` for the required gems and make sure they're installed.

2. **Set Up the Environment Variables:** Habitat requires certain environment variables to be set. Create a `.env` file in the project root with the variables:
```env
TOKEN=your_telegram_bot_token_here
USER_ID=your_telegram_user_id_here
```

Replace `your_telegram_bot_token_here` and `your_telegram_user_id_here` with a bot token you got from botfather (you'll need to create a bot, but that's simple), and your user id which you can find somewhere in the settings (it's just a big ol' integer)

## Running Habitat

After setting up, you can run Habitat with the following command:

```bash
chmod +x dev.sh
./dev.sh
```

This command will start the Telegram bot. You can now send `/start` into the bot chat to begin using it.

