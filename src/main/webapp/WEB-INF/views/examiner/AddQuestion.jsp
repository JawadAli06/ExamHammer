<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h3>Add Question</h3>

<form action="/examiner/saveQuestion" method="post">

    <div class="mb-3">
        <label>Question</label>
        <textarea name="questionText" class="form-control" required></textarea>
    </div>

    <div class="mb-3">
        <label>Marks</label>
        <input type="number" name="marks" class="form-control" required>
    </div>

    <button class="btn btn-primary">Save</button>

</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
