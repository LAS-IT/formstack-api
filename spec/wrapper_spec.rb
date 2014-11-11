require_relative '../lib/formstack/api'

RSpec.describe Formstack::API do

  subject(:wrapper) { Formstack::API.new(access_token) }
  let(:access_token) { ACCESS_TOKEN }
  let(:valid_form_id) { FORM_ID }
  let(:invalid_form_id) { 1234 }
  let(:inaccessible_form_id) { INACCESSIBLE_FORM_ID }

  describe '#request', :vcr do

    it 'raises an exception when endpoint is empty' do
      expect{wrapper.request('')}.to raise_exception('Missing End Point')
    end

    it 'raises an exception with a bad verb' do
      expect{wrapper.request('/test/endpoint', 'FAIL')}.to raise_exception('Wrong verb')
    end

    let(:access_token) { 'fail' }
    it 'raises an exception with a bad token' do
      expect{wrapper.request('form.json')}.to raise_exception('Bad token')
    end
  end

  describe '#forms', :vcr do
    it 'responds with no folders by default' do
      forms = wrapper.forms
      expect(forms.class).to eq(Array)
    end

    it 'gets folders when asked' do
      folders = wrapper.forms(true)
      expect(folders.class).to eq(Hash)
    end
  end

  describe '#form_details', :vcr do
    it 'reads a form name' do
      form = wrapper.form_details(valid_form_id)
      expect(form['name']).to eq('Test Form')
    end

    it 'raises an error if form id is not a number' do
      expect{wrapper.form_details('TEXT')}.to raise_exception('Form ID must be numeric')
    end

    it 'responds with an error if form id doesnt exist' do
      response = wrapper.form_details(invalid_form_id)
      expect(response['status']).to eq('error')
      expect(response['error']).to eq('The form was not found')
    end

    it 'responds with an error if you dont have access to form' do
      response = wrapper.form_details(inaccessible_form_id)
      expect(response['status']).to eq('error')
      expect(response['error']).to eq('You do not have high enough permissions for this form.')
    end
  end

  describe '#copy_form', :vcr do
    it 'adds COPY at the end of the form name' do
      form = wrapper.form_details(valid_form_id)
      copied_form = wrapper.copy_form(valid_form_id)
      expect(copied_form['name']).to match(/^#{form['name']} - COPY/)
    end

    it 'raises an error if form id is not a number' do
      expect{wrapper.copy_form('TEXT')}.to raise_exception('Form ID must be numeric')
    end

    it 'raises an error if form id is invalid' do
      response = wrapper.copy_form(invalid_form_id)
      expect(response['status']).to eq('error')
      expect(response['error']).to eq('A valid form id was not supplied')
    end
  end

  describe '#form_submissions', :vcr do
    it 'gets submissions default' do
      form = wrapper.form_details(valid_form_id)
      submissions_count = form['submissions'].to_i > 25 ? 25 : form['submissions'].to_i

      submissions = wrapper.form_submissions(valid_form_id)
      expect(submissions_count).to eq(submissions.count)
    end

    it 'raises an error if form id isnt numeric' do
      expect{wrapper.form_submissions('TEXT')}.to raise_exception('Form ID must be numeric')
    end

    it 'raises an error if min time is invalid' do
      expect{wrapper.form_submissions(valid_form_id, '', 'BAD')}.to raise_exception('Invalid value for minTime parameter')
    end

    it 'raises an error if max time is invalid' do
      expect{wrapper.form_submissions(valid_form_id, '', '', 'BAD')}.to raise_exception('Invalid value for maxTime parameter')
    end

    it 'raises an error for a search mismatch' do
      field_ids = [1, 2, 3]
      field_values = ['test-1', 'test-2']
      expect{wrapper.form_submissions(valid_form_id, '', '', '', field_ids, field_values)}.to raise_exception('You must have a one to one relationship')
    end

    it 'raises an error for a search mismatch reversed' do
      field_ids = [1, 2]
      field_values = ['test-1', 'test-2', 'test-3']
      expect{wrapper.form_submissions(valid_form_id, '', '', '', field_ids, field_values)}.to raise_exception('You must have a one to one relationship')
    end

    it 'raises an error if field ids are not numeric' do
      field_ids = [1, 'two']
      field_values = ['test-1', 'test-2']
      expect{wrapper.form_submissions(valid_form_id, '', '', '', field_ids, field_values)}.to raise_exception('Field IDs must be numeric')
    end

    it 'raises an error if per_page is not numeric' do
      expect{wrapper.form_submissions(valid_form_id, '', '', '', [], [], 1, 'fail')}.to raise_exception('The perPage value must be numeric')
    end

    it 'raises an error if requests per page are less than 1' do
      expect{wrapper.form_submissions(valid_form_id, '', '', '', [], [], 1, 0)}.to raise_exception('You can only retrieve a minimum of 1 and maximum of 100 submissions per request')
    end

    it 'raises an error if requests per page are more than 100' do
      expect{wrapper.form_submissions(valid_form_id, '', '', '', [], [], 1, 101)}.to raise_exception('You can only retrieve a minimum of 1 and maximum of 100 submissions per request')
    end

    it 'raises an error if page_number is not numeric' do
      expect{wrapper.form_submissions(valid_form_id, '', '', '', [], [], 'fail')}.to raise_exception('The pageNumber value must be numeric')
    end

    it 'raises an error if page number is not working'

    it 'raises an error if the sort parameter is invalid' do
      expect{wrapper.form_submissions(valid_form_id, '', '', '', [], [], 1, 100, 'fail')}.to raise_exception('The sort parameter must be ASC or DESC')
    end

    it 'returns false with no data'
    it 'returns true with data'

  end
end
