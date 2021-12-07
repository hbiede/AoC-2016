# AoC-Template
A template repo for use in the Advent of Code

The README_template.md must contain "STATS_TABLE" to be replaced by the generated table, and the stats graphs will be placed in `statsImages/` with the following file names: `part1time.png`, `part2time.png`, `part1rank.png`, `part2rank.png`, `part1score.png`, and `part2score.png`

## Setup
1. Login to [Advent of Code](https://adventofcode.com), open the cookie storage section of the developer window for the website and copy the session value
1. Run `make cookie SESSION=(session value from step 1)`
1. Run `make setup`

## Usage
1. Run `make DAY=XX` (e.g., `make DAY=1`) to download the challenge input and README
1. After completing part 1, run `make download DAY=XX` to update the day's README with part 2's description
3. After completing part 2, run `make stats` to update the main README
