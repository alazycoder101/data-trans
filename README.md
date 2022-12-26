# Function
1. stats
* average
* max

2. transform
* strip
* remove

3. split into chunks based on record count

4. benchmark

# Further Improvement
1. Use more function programming
2. write json to stream to save cost of memory
* processor need to change
* stats can be kept the same
3. Split works same way as bechmark
4. Observer design pattern?


# Development
## Setup
### Docker
```
docker build -t cli .
docker run -v /home/app:/opt/app -ti --rm cli sh

# run the command
bin/json_process -f spec/fixtures/10.json -v
```
### Native
```bash
gem install bundler
bundle install
```

## Lint
```
rubocop --auto-gen-config
```

## JSON parser
[oj](https://github.com/ohler55/oj)
[fast_jsonparser](https://github.com/anilmaurya/fast_jsonparser)

## benchmarking
[bencharmk](https://github.com/ruby/benchmark)

## JSON stream writer
[json-stream-writer](https://github.com/camertron/json-write-stream)

## Test
```
COVERAGE=true rspec spec
```
