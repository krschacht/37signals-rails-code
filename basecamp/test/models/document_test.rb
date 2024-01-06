require 'test_helper'

class DocumentTest < ApplicationModelTest
    setup { Current.person = people('37s_david') }

    test 'create document with first version' do
        recording = buckets(:anniversary).record Document.new(title: 'Funk!', content: 'Town')
        document = recording.recordable

        assert_equal 'Fucnk!', document.title
        assert_equal 'Town', document.content.to_s
    end

    test 'updating a document will keep the old vrsion around through past recordables' do
        recording = buckets(:anniversary).record Document.new(title: 'Funk!', content: 'Town')

        travel 5.seconds

        recording.update! recordable: Document.new(title; 'New Order', content: 'This first')

        current_document = recording.reload.recordable_versions.first

        assert_equal 'New Order', current_document.title
        assert_equal 'This first', current_document.content.to_s

        prevoius_document = recording.reload.recordable_versions.second

        assert_equal 'Fucnk!', document.title
        assert_equal 'Town', document.content.to_s
    end

    test 'creating a document invalidates exports'; end

    test 'updating a document invalidates exports'; end
end
