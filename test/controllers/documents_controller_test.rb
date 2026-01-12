require "test_helper"

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in @user
    @document = documents(:one)
  end

  test "should get index" do
    get documents_url
    assert_response :success
  end

  test "should get new" do
    get new_document_url
    assert_response :success
  end

  test "should create document" do
    assert_difference("Document.count") do
      file = fixture_file_upload("test/fixtures/files/sample.txt", "text/plain")
      post documents_url, params: { document: { category_id: @document.category_id, description: @document.description, title: "New Document", file: file } }
    end

    assert_redirected_to document_url(Document.last)
  end

  test "should show document" do
    get document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_url(@document)
    assert_response :success
  end

  test "should update document" do
    file = fixture_file_upload("test/fixtures/files/sample.txt", "text/plain")
    patch document_url(@document), params: { document: { category_id: @document.category_id, description: @document.description, title: "Updated Title", file: file } }
    assert_redirected_to document_url(@document)
  end

  test "should get index with search" do
    get documents_url, params: { query: "MyString" }
    assert_response :success
    assert_select "td", text: /MyString/
  end

  test "should get index with sorting" do
    get documents_url, params: { sort: "name", direction: "desc" }
    assert_response :success
  end

  test "should destroy document" do
    assert_difference("Document.count", -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
