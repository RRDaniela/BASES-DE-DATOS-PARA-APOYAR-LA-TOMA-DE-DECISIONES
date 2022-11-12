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

//Salida---------------------------------------------
//Crear los nodos tipo Salida
LOAD CSV WITH HEADERS FROM "file:///Salida.csv" AS row
CREATE(n:Salida)
SET n=row

//Crear el índice para los nodos Salida
CREATE INDEX index_Salida FOR (n:Salida) ON (n.Id_Salida)

//Visualizar grafo Salida
MATCH (n:Salida) return n
