require 'test_helper'

class Recording::LockTest < ApplicationModelTest
  setup { Current.person = people('37s_david') }

  test 'locking a recording' do
    recordings(:planning_document).lock_by(users('37s_david'))
    assert recordings(:planning_document).locked?
    assert_equal users('37s_david'), recordings(:planning_document).lock.user
  end

  test 'trying to lock an already locked recording will fail' do
    assert recordings(:planning_document).lock_by(users('37s_david'))

    assert !recordings(:planning_document).lock_by(users('37s_jason'))
  end

  test 'unlock a recording' do
    recordings(:planning_document).lock_by users('37s_david')
    assert recordings(:planning_document).locked?

    recordings(:planning_document).unlock
    assert !recordings(:planning_document).locked?
  end

  test 'recording was locked by the user viewing the lock' do
    recordings(:planning_document).lock_by users('37s_david')
    assert recordings(:planning_document).locked_by?(users('37s_david'))
  end
end
