require 'spec_helper'
require 'action_view'



describe 'FormHelper interaction' do
  let :dummy_class do
    Dummy = Class.new do include ActionView::Helpers::FormHelper end
  end

  let(:dummy_view) { dummy_class.new }
  let(:account   ) { Account.new     }

  before {
    dummy_view.stub dom_class: 'a', dom_id: 'b', polymorphic_path: 'c',
    :'output_buffer=' => 'd', output_buffer: 'e', protect_against_forgery?: false
  }

  specify{
    dummy_view.form_for account do |f|
      f.label :mobile_phone
      f.text_field :mobile_phone

      f.label :home_phone
      f.text_field :home_phone
    end
  }
end
