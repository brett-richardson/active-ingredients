require 'spec_helper'
require 'fixtures/phone'


describe Phone do
  let(:country_code){ '+64' }
  let(:number      ){ '21 321 7641' }
  let(:full_number ){ "#{ country_code } #{ number }" }

  describe 'construction' do
    context 'given a single argument' do
      subject{ described_class.new full_number }

      it 'receives #convert' do
        described_class.any_instance.should_receive(:convert).with full_number
        subject
      end

      # it{ binding.pry }
      its(:country_code){ should eq '+64'         }
      its(:number      ){ should eq '21 321 7641' }
    end

    context 'given a multiple arguments' do
      subject{ described_class.new country_code: country_code, number: number }

      it 'does not receive #convert' do
        described_class.any_instance.should_not_receive :convert
        subject
      end

      its(:country_code){ should eq '+64'         }
      its(:number      ){ should eq '21 321 7641' }
    end
  end
end
