# Development
## Setup
### Docker
```
docker build -t cli .
docker run -v /home/app:/opt/app -ti --rm cli sh
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
