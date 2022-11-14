//ALMACEN--------------------------------------------------

//Crear los nodos tipo almacen
LOAD CSV WITH HEADERS FROM "file:///Almacen.csv" AS row
CREATE(n:Almacen)
SET n=row

//Crear el índice para los nodos almacén
CREATE INDEX index_Almacen FOR (n:Almacen) ON (n.Id_Almacen)

//Visualizar grafo almacen
MATCH (n:Almacen) return n

//ARTICULO-------------------------------------------------

//Crear los nodos tipo articulo
LOAD CSV WITH HEADERS FROM "file:///Articulo.csv" AS row
CREATE(n:Articulo)
SET n=row

//Crear el índice para los nodos articulo
CREATE INDEX index_Articulo FOR (n:Articulo) ON (n.id_articulo)

//Visualizar grafo articulo
MATCH (n:Articulo) return n

//ARTICULO GRUPO---------------------------------------------
//Crear los nodos tipo articulo grupo
LOAD CSV WITH HEADERS FROM "file:///ArticuloGrupo.csv" AS row
CREATE(n:ArticuloGrupo)
SET n=row

//Crear el índice para los nodos articulo grupo
CREATE INDEX index_ArticuloGrupo FOR (n:ArticuloGrupo) ON (n.id_articulogrupo)

//Visualizar grafo articulo grupo
MATCH (n:ArticuloGrupo) return n

//ARTICULO TIPO---------------------------------------------
//Crear los nodos tipo articulo tipo
LOAD CSV WITH HEADERS FROM "file:///ArticuloTipo.csv" AS row
CREATE(n:ArticuloTipo)
SET n=row

//Crear el índice para los nodos articulo Tipo
CREATE INDEX index_ArticuloTipo FOR (n:ArticuloTipo) ON (n.id_articulotipo)

//Visualizar grafo articulo tipo
MATCH (n:ArticuloTipo) return n

//Cliente---------------------------------------------
//Crear los nodos tipo Cliente
LOAD CSV WITH HEADERS FROM "file:///Cliente.csv" AS row
CREATE(n:Cliente)
SET n=row

//Crear el índice para los nodos Cliente
CREATE INDEX index_Cliente FOR (n:Cliente) ON (n.Id_Cliente)

//Visualizar grafo Cliente
MATCH (n:Cliente) return n

//Factura---------------------------------------------
//Crear los nodos tipo Factura
LOAD CSV WITH HEADERS FROM "file:///Factura.csv" AS row
CREATE(n:Factura)
SET n=row

//Crear el índice para los nodos Factura
CREATE INDEX index_Factura FOR (n:Factura) ON (n.Id_Factura)

//Visualizar grafo Factura
MATCH (n:Factura) return n

//Factura_D---------------------------------------------
//Crear los nodos tipo Factura_D
LOAD CSV WITH HEADERS FROM "file:///Factura_D.csv" AS row
CREATE(n:Factura_D)
SET n=row

//Crear el índice para los nodos Factura_D
CREATE INDEX index_Factura_D FOR (n:Factura_D) ON (n.Id_Factura_d)

//Visualizar grafo Factura_D
MATCH (n:Factura_D) return n

//Proveedor---------------------------------------------
//Crear los nodos tipo Proveedor
LOAD CSV WITH HEADERS FROM "file:///Proveedor.csv" AS row
CREATE(n:Proveedor)
SET n=row

//Crear el índice para los nodos Proveedor
CREATE INDEX index_Proveedor FOR (n:Proveedor) ON (n.Id_Proveedor)

//Visualizar grafo Proveedor
MATCH (n:Proveedor) return n

//ProveedorFactura---------------------------------------------
//Crear los nodos tipo ProveedorFactura
LOAD CSV WITH HEADERS FROM "file:///ProveedorFactura.csv" AS row
CREATE(n:ProveedorFactura)
SET n=row

//Crear el índice para los nodos ProveedorFactura
CREATE INDEX index_ProveedorFactura FOR (n:ProveedorFactura) ON (n.Id_ProveedorFactura)

//Visualizar grafo ProveedorFactura
MATCH (n:ProveedorFactura) return n

//ProveedorFacturaD---------------------------------------------
//Crear los nodos tipo ProveedorFacturaD
LOAD CSV WITH HEADERS FROM "file:///ProveedorFacturaD.csv" AS row
CREATE(n:ProveedorFacturaD)
SET n=row

//Crear el índice para los nodos ProveedorFacturaD
CREATE INDEX index_ProveedorFacturaD FOR (n:ProveedorFacturaD) ON (n.Id_ProveedorFactura_d)

//Visualizar grafo ProveedorFacturaD
MATCH (n:ProveedorFacturaD) return n

//SalidaD---------------------------------------------
//Crear los nodos tipo SalidaD
LOAD CSV WITH HEADERS FROM "file:///Salida_D.csv" AS row
CREATE(n:SalidaD)
SET n=row

//Crear el índice para los nodos SalidaD
CREATE INDEX index_SalidaD FOR (n:SalidaD) ON (n.Id_Salida_d)

//Visualizar grafo SalidaD
MATCH (n:SalidaD) return n

//Salida---------------------------------------------
//Crear los nodos tipo Salida
LOAD CSV WITH HEADERS FROM "file:///Salida.csv" AS row
CREATE(n:Salida)
SET n=row

//Crear el índice para los nodos Salida
CREATE INDEX index_Salida FOR (n:Salida) ON (n.Id_Salida)

//Visualizar grafo Salida
MATCH (n:Salida) return n

//Crear relación entre ARTÍCULO y ARTÍCULO TIPO
MATCH (a:Articulo)
MATCH (ag:ArticuloGrupo)
WHERE ag.id_articulogrupo = a.id_articulogrupo
MERGE (a)-[:TIENE_UN]->(ag)

//Se borró la relación entre los nodos porque la relación era con TIPO no con GRUPO
MATCH(a:Articulo)-[r:TIENE_UN]->(ag:ArticuloGrupo)
DELETE r

//Crear relación entre ARTÍCULO y ARTÍCULO TIPO
MATCH (a:Articulo)
MATCH (at:ArticuloTipo)
WHERE a.id_articulotipo = at.id_articulotipo
MERGE (a)-[:TIENE_UN]->(at)

//Crear relación entre ARTÍCULO y ARTÍCULO GRUPO
MATCH (a:Articulo)
MATCH (ag:ArticuloGrupo)
WHERE a.id_articulogrupo = ag.id_articulogrupo
MERGE (a)-[:PERTENECE_A]->(ag)

//CREAR RELACIÓN ENTRE ARTÍCULO Y PROVEEDOR FACTURA_D
MATCH (a:Articulo)
MATCH (pdf:ProveedorFacturaD)
WHERE a.id_articulo = pdf.id_articulo
MERGE (pdf)-[:INCLUYE]->(a)

//CREAR RELACIÓN ENTRE PROVEEDOR FACTURA_D Y PROVEEDOR FACTURA
MATCH (pf:ProveedorFactura)
MATCH (pdf:ProveedorFacturaD)
WHERE pf.id_ProveedorFactura = pdf.id_proveedorfactura
MERGE (pf)-[:ENGLOBA]->(pdf)

//CREAR RELACIÓN ENTRE PROVEEDOR Y PROVEEDOR FACTURA
MATCH (pf:ProveedorFactura)
MATCH (p:Proveedor)
WHERE pf.id_Proveedor = p.Id_Proveedor
MERGE (p)-[:GENERAN]->(pf)

//CREAR RELACIÓN ENTRE ARTICULO Y SALIDA_D
MATCH (a:Articulo)
MATCH (sd:SalidaD)
WHERE a.id_articulo = sd.id_articulo
MERGE (sd)-[:CONTIENE]->(a)

//CREAR RELACIÓN ENTRE salida Y SALIDA_D
MATCH (s:Salida)
MATCH (sd:SalidaD)
WHERE s.Id_Salida = sd.Id_Salida
MERGE (sd)-[:ES_PARTE_DE]->(s)

//CREAR RELACIÓN ENTRE SALIDA Y ALMACÉN
MATCH (s:Salida)
MATCH (a:Almacen)
WHERE s.Id_Almacen = a.Id_Almacen
MERGE (s)-[:PROVIENE_DE]->(a)

//CREAR RELACIÓN ENTRE SALIDA Y CLIENTE
MATCH (s:Salida)
MATCH (c:Cliente)
WHERE s.id_cliente = c.Id_Cliente
MERGE (s)-[:PERTENECE_A_UN]->(c)

//CREAR RELACIÓN ENTRE CLIENTE Y FACTURA
MATCH (F:Factura)
MATCH (c:Cliente)
WHERE F.Id_Cliente = c.Id_Cliente
MERGE (F)-[:CORRESPONDE_A]->(c)

//CREAR RELACIÓN ENTRE  FACTURA y FACTURA_D
MATCH (F:Factura)
MATCH (FD:Factura_D)
WHERE F.Id_Factura = FD.Id_Factura
MERGE (FD)-[:FORMA_PARTE_DE]->(F)
