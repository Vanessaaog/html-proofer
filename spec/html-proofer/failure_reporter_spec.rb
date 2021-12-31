# frozen_string_literal: true

require 'spec_helper'

describe HTMLProofer::FailureReporter do
  describe 'cli_report' do
    it 'reports all issues accurately' do
      errors = File.join(FIXTURES_DIR, 'sorting', 'kitchen_sinkish.html')
      output = capture_proofer_output(errors, :file, log_level: :info, checks: %w[Links Images Scripts Favicon])

      msg = <<~MSG
        For the Favicon check, the following failures were found:

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html:

           no favicon specified

        For the Images check, the following failures were found:

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 5:

           internal image ./gpl.png does not exist

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 5:

           image ./gpl.png does not have an alt attribute

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 6:

           internal image NOT_AN_IMAGE does not exist

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 10:

           internal image gpl.png does not exist

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 10:

           image gpl.png does not have an alt attribute

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 12:

           image has a terrible filename (./Screen Shot 2012-08-09 at 7.51.18 AM.png)

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 12:

           internal image ./Screen Shot 2012-08-09 at 7.51.18 AM.png does not exist

        For the Links check, the following failures were found:

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 8:

           tel: contains no phone number

        For the Links > External check, the following failures were found:

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 14:

           External link https://upload.wikimedia.org/wikipedia/en/thumb/not_here.png failed: 404 No error

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 19:

           External link https://upload.wikimedia.org/wikipedia/en/thumb/fooooof.png failed: 404 No error

        * In spec/html-proofer/fixtures/sorting/kitchen_sinkish.html on line 26:

           External link https://help.github.com/changing-author-info/ failed: 404 No error

        For the Links > Internal check, the following failures were found:

        * In nowhere.fooof on line 24:

           internally linking to nowhere.fooof, which does not exist


        HTML-Proofer found 13 failures!
      MSG

      expect(output).to match(msg)
    end
  end
end
