Para realizar a query 1:
- criei uma tabela para analise onde vou realizar as querys com base nas tabelas purchase e campaign
- utilizei um insert na coluna client_id from campanhas

Para realizar a query 2:
- Criei uma tabela temporária para realizar o cálculo de gastos totais por cada cliente
- Depois trouxe a tabela analises o calculo de cada cliente

Para realizar a query 3:
- Criei uma tabela temporária temp_most_purchase_location que identifica o local de compra mais frequente para cada cliente
- Atualiza a tabela analises com o local de compra mais frequente, substituindo o valor atual com o valor da tabela temp_most_purchase_location

Para realizar a query 4:
- Criei uma tabela temporária temp_first_purchase que calcula a data da primeira compra para cada cliente, usando a função MIN para encontrar a data mais antiga
- Atualiza a tabela analises com a data da primeira compra, substituindo o valor atual com o valor da tabela temp_first_purchase

Para realizar a query 5:
Criei uma tabela temporária temp_last_purchase que calcula a data da última compra para cada cliente, usando a função MAX para encontrar a data mais recente
-  Atualiza a tabela analises com a data da última compra, substituindo o valor atual com o valor da tabela temp_last_purchase

Para realizar a query 6:
- Criei uma tabela temporária temp_campaign_counts que conta a quantidade de campanhas recebidas para cada cliente e tipo de campanha
- Criei uma tabela temporária temp_ranked_campaigns que rankeia campanhas para cada cliente com base na contagem de campanhas recebidas
-  Criei a tabela most_campaign que contém a campanha mais frequente para cada cliente com base no rank mais alto
- Atualiza a tabela analises com a campanha mais frequente, substituindo o valor atual com o valor da tabela most_campaign

Para realizar a query 7:
- Criei uma tabela temporária temp_quantity_error que conta a quantidade de campanhas com status de erro para cada cliente
- Atualiza a tabela analises com a quantidade de campanhas com status de erro, substituindo o valor atual com o valor da tabela temp_quantity_error e usando 0 se não houver erros

Para realizar a query 8:
- Atualiza a tabela analises com a data atual na coluna data_today, preservando o restante dos dados

Para realizar a query 9:
- Atualiza a tabela analises com um código de data no formato MMYYYY na coluna anomes_today, calculado a partir da data atual