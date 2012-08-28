require 'spec_helper'

describe TopHat::HtmlHelper do
  before(:each) do
    @template = ActionView::Base.new
  end

  describe 'html_tag' do
    it 'returns a simple tag by default' do
      @template.html_tag.should eq('<html>')
    end

    it 'accepts a version in an options hash' do
      output = @template.html_tag(:version => '123')
      output.should eq('<html version="123">')
    end

    context 'xmlns' do
      it 'accepts xmlns passed as strings' do
        output = @template.html_tag(:xmlns => 'http://someurl.com')
        output.should eq('<html xmlns="http://someurl.com">')
      end

      it 'accepts xmlns passed as hashes' do
        output = @template.html_tag(:xmlns => { :prefix => 'fb', :url => 'http://someurl.com' })
        output.should eq('<html xmlns:fb="http://someurl.com">')
      end

      it 'accepts xmlns passed as an array of hashes' do
        xmlns = { :prefix => 'fb', :url => 'http://developers.facebook.com/schema/' }
        output = @template.html_tag(:xmlns => [xmlns])
        output.should eq('<html xmlns:fb="http://developers.facebook.com/schema/">')
      end
    end

    context 'prefixes' do
      it 'accepts prefixes passed as strings' do
        output = @template.html_tag(:prefix => 'ohai')
        output.should eq('<html prefix="ohai">')
      end

      it 'accepts prefixes passed as a hash' do
        output = @template.html_tag(:prefix => { :prefix => 'og', :url => 'http://ogp.me/ns#' })
        output.should eq('<html prefix="og: http://ogp.me/ns#">')
      end

      it 'accepts prefixes passed as an array of hashes' do
        prefixes = [
          { :prefix => 'og', :url => 'http://ogp.me/ns#' },
          { :prefix => 'fb', :url => 'http://ogp.me/ns/fb#' }
        ]
        output = @template.html_tag(:prefix => prefixes)
        output.should eq('<html prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb#">')
      end

      it 'accepts prefixes passes and an array of strings' do
        output = @template.html_tag(:prefix => ['og: http://ogp.me/ns#', 'fb: http://ogp.me/ns/fb#'])
        output.should eq('<html prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb#">')
      end
    end

  end
end