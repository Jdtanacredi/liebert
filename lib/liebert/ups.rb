require_relative 'scrapable'

class UPS
  attr_accessor :endpoint_uri
  ATTRS = %i(input_amps output_amps battery_voltage charge)

  include Scrapable

  def initialize(hostname = nil)
    @endpoint_uri = "http://#{hostname}/graphic/smallUps.htm" unless hostname.nil?
    create_getters
  end

  def scrape_input_amps
    @input_amps = @parsed_response.xpath('//*[@id="InputAmps"]/td[2]').children.text.match(/(\d.*)/)[1].strip.to_f
  end

  def scrape_output_amps
    @output_amps = @parsed_response.xpath('//*[@id="OutputAmps"]/td[2]').children.text.match(/(\d.*)/)[1].strip.to_f
  end

  def scrape_battery_voltage
    @battery_voltage = @parsed_response.xpath('//*[@id="Battery"]/table/tr/td/center/table/tr[1]/td[2]').children.text.match(/(\d.*)/)[1].strip.to_f
  end

  def scrape_charge
    @charge = @parsed_response.xpath('//*[@id="Battery"]/table/tr/td/center/table/tr[3]/td[2]').children.text.match(/(\d.*)/)[1].strip.to_f
  end
end
