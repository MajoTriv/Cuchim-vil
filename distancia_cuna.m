% Longitudes de los eslabones (en cm)
L_verde = 4;
L_purpura = 3;
L_amarillo = 1.5;

% Definir rangos de ángulos
theta1_range = 0:15:360; % Ángulo de la manivela (en grados)
theta2_range = -90:15:90; % Ángulo del balancín (en grados)

% Inicializar matrices para almacenar resultados
results = [];

% Cálculo de las posiciones
for theta1_deg = theta1_range
    for theta2_deg = theta2_range
        % Convertir ángulos de grados a radianes
        theta1 = deg2rad(theta1_deg);
        theta2 = deg2rad(theta2_deg);
        
        % Ecuaciones de posición del extremo de la cuchilla
        x_D = L_verde * cos(theta1) + ...
              L_purpura * cos(theta1 + theta2) + ...
              L_amarillo * cos(theta1 + theta2 + pi/4); % 45° = pi/4 rad
        y_D = L_verde * sin(theta1) + ...
              L_purpura * sin(theta1 + theta2) + ...
              L_amarillo * sin(theta1 + theta2 + pi/4);
        
        % Almacenar resultados
        results = [results; theta1_deg, theta2_deg, x_D, y_D];
    end
end

% Crear tabla de resultados
result_table = array2table(results, ...
    'VariableNames', {'Theta1_deg', 'Theta2_deg', 'x_D_cm', 'y_D_cm'});

% Mostrar los primeros resultados
disp('Primeras filas de la tabla de posiciones:');
disp(result_table(1:10, :));

% Graficar la trayectoria
figure;
plot(results(:, 3), results(:, 4), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'b');
title('Trayectoria del extremo de la cuchilla (Punto D)', 'FontSize', 14);
xlabel('x_D (cm)', 'FontSize', 12);
ylabel('y_D (cm)', 'FontSize', 12);
grid on;
axis equal;

% Opcional: Guardar resultados en un archivo CSV
writetable(result_table, 'trayectoria_cuchilla.csv');
disp('Los resultados se han guardado en el archivo "trayectoria_cuchilla.csv".');
