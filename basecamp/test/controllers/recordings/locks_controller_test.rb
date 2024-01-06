class Recordings::LocksControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as '37s_david' }

  test 'show lock when a recording ahs been locked by someone else' do
    recording = recordings(:introduction_document)
    recording.lock_by(users('37s_jason'))

    get bucket_recording_lock_url(recording.bucket, recording)
    assert_response :ok

    assert_select 'h1', text: /This document is locked/
  end

  test 'show correct lock when a recording has been locked by self' do
    recording = recordings(:introduction_document)
    recording.lock_by(users('37s_david'))

    get bucket_recording_lock_url(recording.bucket, recording)
    assert_response :ok

    assert_select 'h1', text: /Look like you already started editing this document./
  end

  test 'redirect when the recording is not locked' do
    recording = recordings(:introduction_document)

    get bucket_recording_lock_url(recording.bucket, recording)
    assert_redirected_to recordable_url(recording)
  end

  test 'unlock and redirect to edit' do
    recording = recordings(:introduction_document)
    recording.lock_by(users('37s_jason'))

    get bucket_recording_lock_url(recording.bucket, recording)
    assert_redirected_to edit_recordable_url(recording)

    assert_not recording.reload.locked?
  end

  test 'unlock and redirect to show' do
    recording = recordings(:introduction_document)
    recording.lock_by(users('37s_jason'))

    get bucket_recording_lock_url(recording.bucket, recording, return_to: 'show')
    assert_redirected_to recordable_url(recording)

    assert_not recording.reload.locked?
  end
end
