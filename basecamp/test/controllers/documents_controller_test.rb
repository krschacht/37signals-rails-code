require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as '37s_david' }

  test 'creating a new document' do
    get new_bucket_vault_document_url(buckets(:anniversary), recordings(:anniversary_vault))

    assert_response :ok
    assert_breadcrumbs 'Docs & Files'

    post bucket_vault_documents_url(buckets(:anniversary), recordings(:anniversary_vault), params: { 
      document: { title: 'Hello World!', content: 'Yes yes' }
    }

    follow_redirect!
    assert_select 'h1', /Hello World/
  end

  test 'creating a new document and editing subscriptions' do
  end

  test 'editing an active document' do
      recording = recordings(:introduction_document)
      assert recording.active?

      get edit_bucket_document_url(recording.bucket, recording)
      assert_response :ok
      assert_breadcrumbs 'Docs & Files > Inroduction'
  end

  test 'editing a draft document' do; end

  test 'updating a document' do
  end
end
