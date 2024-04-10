%% Creazione dati
% Spostamento -> col 1
% Forza -> col 2
% Sforzo -> col 3
% Tempo -> col 4
% Conteggio cicli -> col 5
% Deformazione -> col 11

%prec_1
spostamento_prec_1 = data_prec_1(:,1);
sforzo_prec_1 = data_prec_1(:,3);
forza_prec_1 = data_prec_1(:,2);
tempo_prec_1 = data_prec_1 (:,4);
num_cicli_prec_1 = data_prec_1(:,5);


%prec_2
spostamento_prec_2 = data_prec_2(:,1);
sforzo_prec_2 = data_prec_2(:,3);
forza_prec_2 = data_prec_2(:,2);
tempo_prec_2 = data_prec_2(:,4);
num_cicli_prec_2 = data_prec_2(:,5);


%prec_3
spostamento_prec_3 = data_prec_3(:,1);
sforzo_prec_3 = data_prec_3(:,3);
forza_prec_3 = data_prec_3(:,2);
tempo_prec_3 = data_prec_3(:,4);
num_cicli_prec_3 = data_prec_3(:,5);

%ril
spostamento_ril = data_ril(:,1);
forza_ril = data_ril(:,2);
sforzo_ril = data_ril(:,3);
tempo_ril = data_ril(:,4);
deformazione_ril = data_ril(:,11);

%rott
spostamento_rott = data_rott(:,1);
forza_rott = data_rott(:,2);
sforzo_rott = data_rott(:,3);
tempo_rott = data_rott(:,4);
deformazione_rott = data_rott(:,11);


%% isteresi
%Eliminare le prime 5 curve per ogni test, delle restanti 5 fare la media,
%calcolare l'energia di deformzione e valutare come cambia a seconda del
%numero della prova.

%plot precondizionamento 1, per prenderci la mano
figure; hold on;
plot(spostamento_prec_1,forza_prec_1,'LineWidth',1.5);
plot(spostamento_prec_2,forza_prec_2,'LineWidth',1.5);
plot(spostamento_prec_3,forza_prec_3,'LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Spostamento[mm]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
grid on;
legend('Precodizionamento 1','Precodizionamento 2','Precodizionamento 3','Location','best');
%% Segmentazione
N = 10; %numero di cicli
cont = 0;


for j = 1:N
    k = 1;
    for i = 1:length(data_prec_1)
        %j indice colonna
        %k tiene traccia del numero di cicl
        %i scansiona il vettore totale
        if j == num_cicli_prec_1(i)+1
            spostamento_prec1_cicli(k,j) = spostamento_prec_1(i);
            tempo_prec1_cicli (k,j) = tempo_prec_1(i);
            forza_prec1_cicli (k,j) = forza_prec_1(i);
            k = k+1;
        end
    end
end
%% Plottiamo l'isteresi, solo gli ultimi 5 cicli
plot(spostamento_prec1_cicli(:,6:10),forza_prec1_cicli(:,6:10),'LineWidth',1.5);

%Facciamo la media ora
spost_medio_prec_1_cicli = mean(spostamento_prec1_cicli(:,6:10),2);
forza_medio_prec_1_cicli = mean(forza_prec1_cicli(:,6:10),2);
plot(spost_medio_prec_1_cicli,forza_medio_prec_1_cicli,'LineWidth',1.5);



%% LEZIONE DEL 26-30
%plottiamo le 10 curve spostameno forza, con sovrapposta la curva media.
%Alla fine dobbiamo farlo per ognuna delle tre prove, e FINALMENTE,
%sovrapporre tutte e tre le prove medie, spacchettiamo i dati del prec2 e
%prec 3

%prec2
for j = 1:N
    k = 1;
    for i = 1:length(data_prec_2)
        %j indice colonna
        %k tiene traccia del numero di cicl
        %i scansiona il vettore totale
        if j == num_cicli_prec_2(i)+1
            spostamento_prec2_cicli(k,j) = spostamento_prec_2(i);
            tempo_prec2_cicli (k,j) = tempo_prec_2(i);
            forza_prec2_cicli (k,j) = forza_prec_2(i);
            k = k+1;
        end
    end
end

%prec3


for j = 1:N
    k = 1;
    for i = 1:length(data_prec_3)
        %j indice colonna
        %k tiene traccia del numero di cicl
        %i scansiona il vettore totale
        if j == num_cicli_prec_3(i)+1
            spostamento_prec3_cicli(k,j) = spostamento_prec_3(i);
            tempo_prec3_cicli (k,j) = tempo_prec_3(i);
            forza_prec3_cicli (k,j) = forza_prec_3(i);
            k = k+1;
        end
    end
end

%curva media 2
spost_medio_prec_2_cicli = mean(spostamento_prec2_cicli(:,6:10),2);
forza_medio_prec_2_cicli = mean(forza_prec2_cicli(:,6:10),2);
%curva media 3
spost_medio_prec_3_cicli = mean(spostamento_prec3_cicli(:,6:10),2);
forza_medio_prec_3_cicli = mean(forza_prec3_cicli(:,6:10),2);

%plot delle tre meide

medie_spost = figure('units','normalized','outerposition',[0 0 1 1]);
plot(spost_medio_prec_1_cicli,forza_medio_prec_1_cicli,'LineWidth',1.5);
hold on;
plot(spost_medio_prec_2_cicli,forza_medio_prec_2_cicli,'LineWidth',1.5);
plot(spost_medio_prec_3_cicli,forza_medio_prec_3_cicli,'LineWidth',1.5);
lg = legend('Ciclo 1', 'Ciclo 2', 'Ciclo 3','Location','best');
lg.FontSize = 22;
set(gca,'Fontsize',22);
xlabel('Spostamento[mm]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
grid on;
hold off
%%
%per capire chi è il carico e lo scarico, plotto la prima metà con un
%colore e la seconda metà con un altro:
segmentazione = figure('units','normalized','outerposition',[0 0 1 1]);
plot(spost_medio_prec_3_cicli(1:length(spost_medio_prec_3_cicli)/2),forza_medio_prec_3_cicli(1:length(forza_medio_prec_3_cicli)/2),'LineWidth',1.5);
hold on;
plot(spost_medio_prec_3_cicli(length(spost_medio_prec_3_cicli)/2+1:end),forza_medio_prec_3_cicli(length(forza_medio_prec_3_cicli)/2+1:end),'LineWidth',1.5,'Color','r');
lg = legend('Carico','Scarico','Location','best');
lg.FontSize = 22;
set(gca,'Fontsize',22);
xlabel('Spostamento[mm]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
grid on;
hold off


%% Area sotto la curva, ci siamo dimenticati dei cicli, solo sulla media.
%eliminiamo un offset iniziale, partivo da F<0, non accettabile.
x_prec1 = spost_medio_prec_1_cicli- spost_medio_prec_1_cicli(1);
y_prec1 = forza_medio_prec_1_cicli-forza_medio_prec_1_cicli(1);

%separiamo carico e scarico e plottiamo:
plot(x_prec1(1:end/2+1),y_prec1(1:end/2+1),'LineWidth',1.5);
hold on;
plot(x_prec1(end/2+2:end),y_prec1(end/2+2:end),'LineWidth',1.5);


%calcoliamo l'area:
isteresi_prec1 = trapz(x_prec1(1:end/2+1),y_prec1(1:end/2+1))-...
    abs(trapz(x_prec1(end/2+2:end),y_prec1(end/2+2:end)))

%replichiamo per le altre due prove:

%eliminiamo un offset iniziale, partivo da F<0, non accettabile.
x_prec2 = spost_medio_prec_2_cicli- spost_medio_prec_2_cicli(1);
y_prec2 = forza_medio_prec_2_cicli-forza_medio_prec_2_cicli(1);

%separiamo carico e scarico e plottiamo:
plot(x_prec2(1:end/2),y_prec2(1:end/2),'LineWidth',1.5);
hold on;
plot(x_prec2(end/2+1:end),y_prec2(end/2+1:end),'LineWidth',1.5);


%calcoliamo l'area:
isteresi_prec2 = trapz(x_prec2(1:end/2),y_prec2(1:end/2))-...
    abs(trapz(x_prec2(end/2+1:end),y_prec2(end/2+1:end)))


%eliminiamo un offset iniziale, partivo da F<0, non accettabile.
x_prec3 = spost_medio_prec_3_cicli- spost_medio_prec_3_cicli(1);
y_prec3 = forza_medio_prec_3_cicli-forza_medio_prec_3_cicli(1);

%separiamo carico e scarico e plottiamo:
plot(x_prec3(1:end/2),y_prec3(1:end/2),'LineWidth',1.5);
hold on;
plot(x_prec3(end/2+1:end),y_prec3(end/2+1:end),'LineWidth',1.5);


%calcoliamo l'area:
isteresi_prec3 = trapz(x_prec3(1:end/2),y_prec3(1:end/2))-...
    abs(trapz(x_prec3(end/2+1:end),y_prec3(end/2+1:end)))

%plottiamo un grafico a barre che confronti i tre dati di isteresi;

bar_plot = figure('units','normalized','outerposition',[0 0 1 1]);
bar([isteresi_prec1 isteresi_prec2 isteresi_prec3]);
set(gca,'Fontsize',22);
xlabel('Numero prova','FontSize',24,'Interpreter','latex');
ylabel('Energia[mJ]','FontSize',24,'Interpreter','latex');
grid on;


%% calcolo area occhiello, è aggiuntivo.

carico_calcolo_aggiuntivo = y_prec1(1:end/2+2);
scarico_calcolo_aggiuntivo = y_prec1(end/2+3:end);
spostamento_carico = x_prec1(1:end/2+2);
spostamento_scarico = x_prec1(end/2+3:end);

scarico_calcolo_aggiuntivo(end-1:end) = [0,0];
figure;
plot(spostamento_carico(1:139),carico_calcolo_aggiuntivo(1:139));
hold on
plot(spostamento_scarico(12:end),scarico_calcolo_aggiuntivo(12:end));

area_effettiva_isteresi = abs(trapz(spostamento_carico(1:139),carico_calcolo_aggiuntivo(1:139)))-...
    abs(trapz(spostamento_scarico(12:end),scarico_calcolo_aggiuntivo(12:end)))

figure;
plot(spostamento_scarico(1:12),scarico_calcolo_aggiuntivo(1:12));
hold on;
plot(spostamento_carico(139:end),carico_calcolo_aggiuntivo(139:end));

area_occhiello =abs(trapz(spostamento_scarico(1:12),scarico_calcolo_aggiuntivo(1:12)))-...
    abs(trapz(spostamento_carico(139:end),carico_calcolo_aggiuntivo(139:end)))
percentuale_occhiello = (area_occhiello/isteresi_prec1)*100
%ist = Abuona - Aocchiello

hold off
%% LEZIONE DEL 05-04-2024

sforzo_def = figure('units','normalized','outerposition',[0 0 1 1]);
plot(deformazione_rott,sforzo_rott,'LineWidth',1.5);
set(gca,'Fontsize',22);
%title('Curva sforzo-deformazione','FontSize',30,'Interpreter','latex');
xlabel('Deformazione[\%]','FontSize',24,'Interpreter','latex');
ylabel('Sforzo[MPa]','FontSize',24,'Interpreter','latex');
grid on;

%ottenuti gli indici con i datatip manualmente, tagliamo i vettori:
lin_in = cursor_info(2).DataIndex;
lin_fin = cursor_info(1).DataIndex;
deformazione_lin = deformazione_rott(lin_in:lin_fin);
sforzo_lin = sforzo_rott(lin_in:lin_fin);

sforzo_def_lin = figure('units','normalized','outerposition',[0 0 1 1]);
plot(deformazione_lin,sforzo_lin,'LineWidth',1.5);
set(gca,'Fontsize',22);
%title('Tratto lineare','FontSize',30,'Interpreter','latex');
xlabel('Deformazione[\%]','FontSize',24,'Interpreter','latex');
ylabel('Sforzo[MPa]','FontSize',24,'Interpreter','latex');
grid on;


%usando polyfit:
lse = polyfit(deformazione_lin,sforzo_lin,1);
young = lse(1);
quota = lse(2);
%plottiamo il risultato:
fitting_sforzo_def_linearizzato=figure('units','normalized','outerposition',[0 0 1 1]);
plot(deformazione_lin(1:7:end),sforzo_lin(1:7:end),'o','LineWidth',1.5);
hold on
plot(deformazione_lin,quota+young*deformazione_lin,'r','LineWidth',1.5);
set(gca,'Fontsize',22);
%title('Fitting','FontSize',30,'Interpreter','latex');
xlabel('Deformazione[\%]','FontSize',24,'Interpreter','latex');
ylabel('Sforzo[MPa]','FontSize',24,'Interpreter','latex');
grid on;
legend('Dati sperimentali','Regressione','Location','best');

%% Rilassamento
rilassamento =figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1);
plot(tempo_ril,spostamento_ril,'LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Tempo[s]','FontSize',24,'Interpreter','latex');
ylabel('Spostamento[mm]','FontSize',24,'Interpreter','latex');
xlim([-2 180]);
grid on;
subplot(2,1,2);
plot(tempo_ril,forza_ril,'r','LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Tempo[s]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
xlim([-2 180]);
ylim([0 max(forza_ril)+max(forza_ril)/100*5]);
grid on;

Fs = 100;%Hz
t_in = 0.3; %s
s_in = Fs*t_in;
tempo_exp_ril = tempo_ril(s_in:end)-tempo_ril(s_in); %riscalo i tempi per far si che t0 = 0
spostamto_exp_ril = spostamento_ril(s_in:end);
forza_exp_ril = forza_ril(s_in:end);

%ri-plottiamo le nostre curve:
rilassamento_no_impluso=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1);
plot(tempo_exp_ril,spostamto_exp_ril,'LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Tempo[s]','FontSize',24,'Interpreter','latex');
ylabel('Spostamento[mm]','FontSize',24,'Interpreter','latex');
xlim([0 180]);
ylim([0 2]);
grid on;
subplot(2,1,2);
plot(tempo_exp_ril,forza_exp_ril,'LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Tempo[s]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
xlim([0 180]);
grid on;
% fatto il fit ottengo:
% Exponential Curve Fit (exp2)
% f(x) = a*exp(b*x) + c*exp(d*x)
% 
% Coefficients and 95% Confidence Bounds
%       Value      Lower      Upper  
% a    12.1464    12.1065    12.1863
% b    -0.0709    -0.0714    -0.0704
% c    86.0049    85.9804    86.0294
% d    -0.0011    -0.0011    -0.0011
% 
% Goodness of Fit
%               Value    
% SSE         2.3834e+03
% R-square    0.9964    
% DFE         17970     
% Adj R-sq    0.9964    
% RMSE        0.3642    
a = 12.1464;
b=  -0.0709;
c = 86.0049;
d =  -0.0011;
tau_1 =-1/b;
tau_2 = -1/d;

fitting_rilassamento = figure('units','normalized','outerposition',[0 0 1 1]);
plot(tempo_exp_ril(1:70:end),forza_exp_ril(1:70:end),'o','LineWidth',1.5);
set(gca,'Fontsize',22);
xlabel('Tempo[s]','FontSize',24,'Interpreter','latex');
ylabel('Forza[N]','FontSize',24,'Interpreter','latex');
xlim([0 180]);
grid on;
hold on
fitted_exp = a*exp(b.*tempo_exp_ril)+c*exp(d.*tempo_exp_ril);
xline(tau_1,'g','LineWidth',1.5);
plot(tempo_exp_ril,fitted_exp,'LineWidth',2);
legend('Dati Sperimentali','$\tau$','Fitting','Interpreter','latex');


%% Export graphics
if allow_export == true
    %isteresi
    exportgraphics(medie_spost,'medie_spost.png','Resolution',300);
    exportgraphics(segmentazione,'segmentazione.png','Resolution',300);
    exportgraphics(bar_plot,'bar_plot.png','Resolution',300);
    %rilassamento
    exportgraphics(rilassamento,'rilassamento.png','Resolution',300);
    exportgraphics(rilassamento_no_impluso,'rilassamento_no_impluso.png','Resolution',300);
    exportgraphics(fitting_rilassamento,'fitting_rilassamento.png','Resolution',300);
    %rottura
    exportgraphics(sforzo_def,'sforzo_def.png','Resolution',300);
    exportgraphics(sforzo_def_lin,'sforzo_def_lin.png','Resolution',300);
    exportgraphics(fitting_sforzo_def_linearizzato,'fitting_sforzo_def_linearizzato.png','Resolution',300);
    
end
