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

## Test
```
COVERAGE=true rspec spec
```

## TODO


