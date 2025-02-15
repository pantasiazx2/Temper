# Temper

precise timer countdowns, etc.

## Install

copy and paste done.

## Usage

```
local Temper = require(path/to/module)

local CountDown = Temper.new({ CountDown = true, Duration = 10 })
local Count = Temper.new()

CountDown:BindCounting(function(countDownTime: number)
	print(countDownTime)
end)

CountDown.CountDownCompleted:Once(function()
	print("yay!")
end)


Count:BindCounting(function(elapsedTime: number)
	print(elapsedTime)
end)

task.delay(5, function()
	Count:Stop()
end)
```

## Contributing


## License

