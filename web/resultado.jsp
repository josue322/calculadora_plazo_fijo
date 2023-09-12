<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Resultado del Cálculo</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="estilo.css"/>
        <link rel="icon" href="u.jpg"/>
    </head>
    <body>
        <h1>Resultado del Cálculo</h1>

        <div class="result-container">
            <p>Monto: <%= request.getAttribute("monto")%> soles</p>
            <p>Plazo: <%= request.getAttribute("plazo")%> años</p>
            <p>Fecha: <%= request.getAttribute("fechaInicio")%></p>
            <p>Tasa de interés: <%= request.getAttribute("tasaInteres")%>%</p>
            <p>Intereses generados: <%= request.getAttribute("intereses")%> soles</p>
            <p>Monto total al vencimiento: <%= request.getAttribute("montoTotal")%> soles</p>
            <p>Fecha de vencimiento: <%= request.getAttribute("fechaVencimiento")%></p>
        </div>


        <table>
            <tr>
                <th>Año</th>
                <th>Fecha de Pago</th>
                <th>Capital</th>
                <th>Interés Anual</th>
                <th>Total</th>
            </tr>
            <%
                BigDecimal monto = new BigDecimal(request.getAttribute("monto").toString());
                BigDecimal intereses = new BigDecimal(request.getAttribute("intereses").toString());
                LocalDate fechaInicio = LocalDate.parse(request.getAttribute("fechaInicio").toString());
                BigDecimal tasaInteres = new BigDecimal(request.getAttribute("tasaInteres").toString());
                LocalDate fechaVencimiento = LocalDate.parse(request.getAttribute("fechaVencimiento").toString());
                int plazo = Integer.parseInt(request.getAttribute("plazo").toString());

                BigDecimal capital = monto;
                BigDecimal gananciaAnual = intereses.divide(new BigDecimal(plazo), 2, RoundingMode.HALF_UP);
                BigDecimal total = capital.add(gananciaAnual);

                for (int i = 1; i <= plazo; i++) {
            %>
            <tr>
                <td><%= i%></td>
                <td><%= fechaInicio.plusYears(i - 1)%></td>
                <td>S/ <%= capital%></td>
                <td>S/ <%= gananciaAnual%></td>
                <td>S/ <%= total%></td>
            </tr>
            <%
                }
            %>
        </table>


    </body>
</html>
