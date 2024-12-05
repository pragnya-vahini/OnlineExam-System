<%
    if(session!=null) session.invalidate();
    response.sendRedirect("index.jsp?message=Session%20is%20invalidated");
%>