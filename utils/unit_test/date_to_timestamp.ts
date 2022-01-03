const HOUR_TIMESTAMP = 3600;
const DAY_TIMESTAMP = 24 * HOUR_TIMESTAMP;

// Timestamps
const TIME_2020_12_1 = getUtcTimestamp(new Date(2020, 11, 1));
const TIME_2020_12_31 = getUtcTimestamp(new Date(2020, 11, 31));
const TIME_2021_1_1 = getUtcTimestamp(new Date(2021, 0, 1));
const TIME_2021_3_31 = getUtcTimestamp(new Date(2021, 2, 31));
const TIME_2021_4_1 = getUtcTimestamp(new Date(2021, 3, 1));
const TIME_2021_4_30 = getUtcTimestamp(new Date(2021, 3, 30));
const TIME_2021_5_1 = getUtcTimestamp(new Date(2021, 4, 1));
const TIME_2021_5_1_1 = TIME_2021_5_1 + 1 * HOUR_TIMESTAMP;
const TIME_2021_5_1_2 = TIME_2021_5_1 + 2 * HOUR_TIMESTAMP;
const TIME_2021_5_31 = getUtcTimestamp(new Date(2021, 4, 31));
const TIME_2023_1_1 = getUtcTimestamp(new Date(2023, 0, 1));

function getUtcTimestamp(date: Date){
  return Math.floor((date.getTime() + date.getTimezoneOffset() * 60 * 1000)/1000);
}