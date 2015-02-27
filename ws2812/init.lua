local NUM_LEDS = 120

print("Resetting LEDs...")

-- initialize leds to black
ws2812.write(3, string.char(0, 0, 0):rep(NUM_LEDS))

s = net.createServer(net.UDP)
s:on("receive",
	function(socket, data)
		local len = string.len(data)

		-- if received package is an art-net package, strip header
		if len >= 18 and string.sub(data, 0, 7) == "Art-Net" then
			data = string.sub(data, 18)
			len = len - 18
		end

		-- send to hardware
		ws2812.write(3, data)
	end)

s:listen(6454)



