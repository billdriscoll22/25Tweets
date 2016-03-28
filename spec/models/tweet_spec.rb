require 'rails_helper'

describe Tweet do
  describe '.within_five_minutes?' do

    before do
      Tweet.create!(screen_name: 'foo', created_at: Time.zone.now - 4.minutes,
                    text: 'blahblah')
      Tweet.create!(screen_name: 'foo', created_at: Time.zone.now - 5.minutes,
                    text: 'blahblah')
      Tweet.create!(screen_name: 'bar', created_at: Time.zone.now - 10.minutes,
                    text: 'blahblah')
    end

    context 'there are no tweets' do
      it 'returns false for given screen name' do
        expect(Tweet.within_five_minutes?('baz')).to eq false
      end

      it 'returns false for given screen name within last 5 minutes' do
        expect(Tweet.within_five_minutes?('bar')).to eq false
      end
    end

    context 'there are tweets' do
      it 'returns true if there are some tweets for given screen name
          within last 5 minutes' do
        expect(Tweet.within_five_minutes?('foo')).to eq true
      end
    end
  end
end
