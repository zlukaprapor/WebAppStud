<%@page import="java.util.*" %>
<%@page import="my.Student" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        h1 {
            text-align: center;
            font-size: 24px;
        }

        #page {
            width: 800px;
            margin: 0 auto;
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease;
        }

        form {
            width: 400px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            animation: slideIn 1s ease;
        }

        input[type=submit] {
            display: block;
            margin: 0 auto;
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type=submit]:hover {
            background-color: #0056b3;
        }


        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .list {
            font-family: Arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        .list th, .list td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        .list th {
            background-color: #f2f2f2;
        }

        .list tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .list tr:hover {
            background-color: #ddd;
        }

        .error {
            color: red;
        }
    </style>
</head>

<body>
<div id="page">
    <h1>Student Form</h1>
    <form method="post" action="">
        <table>
            <tbody>
            <tr>
                <td><label for="name">Name</label></td>
                <td><input id="name" type="text" name="name"></td>
            </tr>
            <tr>
                <td><label for="surname">Surname</label></td>
                <td><input id="surname" type="text" name="surname"></td>
            </tr>
            <tr>
                <td><label for="email">Email</label></td>
                <td><input id="email" type="email" name="email"></td>
            </tr>
            </tbody>
        </table>
        <input type="submit" name="send" value="Send">
    </form>

    <% List<Student> students = (List<Student>) application.getAttribute("students"); %>
    <c:if test="${not empty param.send }">
        <%
            if (students == null) {
                students = new LinkedList<Student>();
                application.setAttribute("students", students);
            }

            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String email = request.getParameter("email");

            if (name != null && !name.trim().isEmpty() && surname != null && !surname.trim().isEmpty()) {
                boolean isDuplicate = false;
                for (Student s : students) {
                    if (s.getName().equals(name) && s.getSurname().equals(surname)) {
                        isDuplicate = true;
                        break;
                    }
                }

                if (!isDuplicate) {
                    Student student = new Student();
                    student.setName(name);
                    student.setSurname(surname);
                    student.setEmail(email);
                    students.add(student);
                } else {
                    out.println("<div class=\"error\">Дублікат імені та прізвища.</div>");
                }
            } else {
                out.println("<div class=\"error\">Некоректне ім'я або прізвище.</div>");
            }
        %>

    </c:if>

    <%
        if (students != null) {
            out.println("<table class=\"list\"><tr><th>Name</th><th>Surname</th><th>Email</th></tr>");
            for (Student s : students) {
                out.println("<tr><td>" + s.getName() + "</td><td>" + s.getSurname() + "</td><td>" + s.getEmail() + "</td></tr>");
            }
            out.println("</table>");
        }
    %>
</div>
</body>
</html>