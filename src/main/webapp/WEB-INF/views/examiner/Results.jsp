<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Exam Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 14px;
        }

        th {
            background: #007bff;
            color: white;
        }

        .pass {
            color: green;
            font-weight: bold;
        }

        .fail {
            color: red;
            font-weight: bold;
        }

        .completed {
            color: blue;
            font-weight: bold;
        }

        .no-data {
            margin-top: 20px;
            color: #666;
            font-size: 16px;
        }
    </style>
</head>
<body>

<h2>Examiner Results</h2>

<c:if test="${empty results}">
    <div class="no-data">No student results found yet.</div>
</c:if>

<c:if test="${not empty results}">
    <table>
        <thead>
            <tr>
                <th>Attempt ID</th>
                <th>Exam Name</th>
                <th>Student Name</th>
                <th>Email</th>
                <th>Score</th>
                <th>Percentage</th>
                <th>Result</th>
                <th>Status</th>
                <th>Completed On</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${results}" var="r">
                <tr>
                    <td>${r.attemptId}</td>
                    <td>${r.exam.examTitle}</td>
                    <td>${r.student.firstName} ${r.student.lastName}</td>
                    <td>${r.student.email}</td>
                    <td>${r.totalScore}</td>
                    <td>${r.percentage}%</td>
                    <td>
                        <c:choose>
                            <c:when test="${r.result == 'PASS'}">
                                <span class="pass">PASS</span>
                            </c:when>
                            <c:otherwise>
                                <span class="fail">FAIL</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <span class="completed">${r.status}</span>
                    </td>
                    <td>${r.endTime}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

</body>
</html>


















