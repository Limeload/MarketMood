# Market Mood

Market Mood is a Sinatra-based web application designed to provide sentiment analysis, financial data, and market news. It integrates with stockdata.org API to fetch real-time data and news related to stocks and financial markets.

## Features

- **Dashboard**: View a summary of sentiment analysis, stock data, and financial news.
- **Stock Data**: Fetches real-time stock prices, intraday data, and end-of-day historical data.
- **Sentiment Analysis**: Displays news articles categorized by positive, neutral, and negative sentiment.
- **Market News**: Provides finance and market news from various sources.
- **Images**: - Illustrations from `undraw.co`

## Deployment

The application is deployed and can be accessed at [Market Mood](https://marketmood-qpcg.onrender.com).

## Installation

1. **Clone the repository:**

   ```bash
   git clone git@github.com:Limeload/MarketMood.git
   cd MarketMood
   ```

2. **Install dependencies:**

   ```bash
   bundle install
   ```

3. **Set up environment variables:**

   Create a `.env` file in the root directory:

   ```plaintext
   STOCK_DATA_KEY=your_stockdata_api_key
   ```

   Replace `your_stockdata_api_key` with your API key from stockdata.org.

4. **Run the application:**

   ```bash
   ruby app.rb
   ```

   The application will be available at `http://localhost:3000`.

## Usage

- Navigate to `http://localhost:3000/dashboard` to view the dashboard.
- Click on different sections to view stock data, sentiment analysis, and market news.

## API Integration

- This application integrates with the stockdata.org API for fetching financial data and news. Ensure you have a valid API key (`STOCK_DATA_KEY`) in your `.env` file.


## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

## License

This project is licensed under the [MIT License](LICENSE).
