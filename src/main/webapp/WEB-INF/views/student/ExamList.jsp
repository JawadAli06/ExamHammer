
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<h3>Available Exams</h3>

<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>Exam Name</th>
            <th>Total Marks</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${exams}" var="e">
            <tr>
                <td>${e.examName}</td>
                <td>${e.totalMarks}</td>
                <td>
                    <a href="/student/startExam/${e.examId}" class="btn btn-primary btn-sm">Start</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
