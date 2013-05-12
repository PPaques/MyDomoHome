class Adc
  attr_reader :channel, :value

  require "i2c/i2c"


  # Command system
  # SD | C2 | C1 | C0 | PD1 | PD0 | X X
  # SD : sigle ended (1)  or différential (0)
  # C2-C0 : Channel Selection
  # PD 1/0 : Power down selection
  #    PD1  PD0
  #     0    0  Power down between A/D conversion
  #     0    1  Internal reference OFF, A/D convert ON
  #     1    0  Internal reference ON , A/D convert OFF
  #     1    1  Internal reference ON , A/D convert ON (NORMAL MODE)

  ADC_ADRESS    = 0x48
  ADC_I2C_DEV   = "/dev/i2c-1"
  # constant with Normal Mode
  ADC_CHANNEL_0 = 0x8C
  ADC_CHANNEL_1 = 0xCC
  ADC_CHANNEL_2 = 0x9C
  ADC_CHANNEL_3 = 0xDC
  ADC_CHANNEL_4 = 0xAC
  ADC_CHANNEL_5 = 0xEC
  ADC_CHANNEL_6 = 0xBC
  ADC_CHANNEL_7 = 0xFC
  # number of byte to read (2*8bits)
  ADC_SIZE      = 0x02

 def initialize(options)
    @channel = options[:channel]
    @value ||= 0
    read
 end

 def read
  @i2c_device = ::I2C.create(ADC_I2C_DEV)

  # send the good command to make the read
  if    channel == 0
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_0)
  elsif channel == 1
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_1)
  elsif channel == 2
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_2)
  elsif channel == 3
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_3)
  elsif channel == 4
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_4)
  elsif channel == 5
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_5)
  elsif channel == 6
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_6)
  elsif channel == 7
    @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_7)
  end

  sleep 0.1
  @value = @i2c_device.read(ADC_ADRESS , ADC_SIZE).unpack("H*")[0].to_i(16)
 end

end