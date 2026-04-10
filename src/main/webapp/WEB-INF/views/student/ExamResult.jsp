<%@ include file="/WEB-INF/views/student/student_header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">
<a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>
    <h3>Exam Result</h3>
    <hr>

    <div class="card shadow p-4">
        <h4>${exam.examName}</h4>
        <p><strong>Student:</strong> ${student.firstName} ${student.lastName}</p>
        <p><strong>Total Questions:</strong> ${totalQuestions}</p>
        <p><strong>Correct Answers:</strong> ${correctCount}</p>
        <p><strong>Wrong Answers:</strong> ${wrongAnswers}</p>
        <p><strong>Unanswered:</strong> ${unanswered}</p>
        <p><strong>Marks Obtained:</strong> ${marksObtained}</p>
        <p><strong>Total Marks:</strong> ${totalMarks}</p>
        <p><strong>Percentage:</strong> ${percentage}%</p>
        <p>
            <strong>Status:</strong>
            <c:choose>
                <c:when test="${passed}">
                    <span class="text-success">Pass</span>
                </c:when>
                <c:otherwise>
                    <span class="text-danger">Fail</span>
                </c:otherwise>
            </c:choose>
        </p>

        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-primary">Back to Dashboard</a>
    </div>
</div>