//¿Cuáles y cuantos son los tipos de nodos?
MATCH (n) RETURN distinct labels(n), count(*)

//3.4. ¿Cuáles y cuantas son los tipos de relaciones?
MATCH (n)-[r]-(m) RETURN distinct type(r), count(r)
MATCH (n)-[r]-(m) RETURN count(distinct (type(r)))

Match (a:Articulo)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:SalidaD)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:Almacen)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:Salida)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:ArticuloGrupo)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:Factura_D)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:ProveedorFacturaD)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:ArticuloTipo)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:Proveedor)
Return distinct labels (a), keys(a)
LIMIT 1


Match (a:Factura)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:ProveedorFactura)
Return distinct labels (a), keys(a)
LIMIT 1

Match (a:Cliente)
Return distinct labels (a), keys(a)
LIMIT 1





//SALIDAS DEL $ALMACEN
MATCH (sd:SalidaD)-[r:ES_PARTE_DE]->(s:Salida)
MATCH (sd:SalidaD)-[r2:CONTIENE]->(a:Articulo)
MATCH (s:Salida)-[r3:PROVIENE_DE]->(am:Almacen)
WHERE am.Descripcion=$almacen
RETURN sd, r, s, r2, a, r3, am

//PRODUCTOS DE $CATEGORIA
MATCH(a:Articulo)-[r:PERTENECE_A]->(ag:ArticuloGrupo)
WHERE ag.descripcion = $CATEGORIA
RETURN a, r, ag

//$PRODUCTOS en facturas
MATCH (a:Articulo)<-[r:CONTIENE]-(sd:SalidaD)
MATCH (sd:SalidaD)-[r2:ES_PARTE_DE]->(s:Salida)
MATCH (s:Salida)-[r3:PERTENECE_A_UN]->(c:Cliente)
MATCH (c:Cliente)<-[r4:CORRESPONDE_A]-(f:Factura)
MATCH (f:Factura)<-[r5:FORMA_PARTE_DE]-(fd:Factura_D)
WHERE a.descripcion = $nombre
RETURN a, r, sd, r2, s, r3, c, r4, f, r5, fd

//TOP 5 NODOS CON MAYOR DEGREE
MATCH (n)-[r]->(p)
RETURN COUNT(r) AS DEGREE
LIMIT 5

MATCH (n)<-[r]-(p)
RETURN n, COUNT(r) AS IN_DEGREE
ORDER BY IN_DEGREE DESC
LIMIT 5

MATCH (n)-[r]->(p)
RETURN n, COUNT(r) AS OUT_DEGREE
ORDER BY OUT_DEGREE DESC
LIMIT 5

//4.4. Realiza una consulta que muestre los proveedores, el número de productos y como 
//lista los nombres de los productos de cada proveedor. 
//CORRECT
MATCH (p:Proveedor)-[r:GENERAN]->(pf:ProveedorFactura)
MATCH (pf:ProveedorFactura)-[r2:ENGLOBA]->(pfd:ProveedorFacturaD)
MATCH (pfd:ProveedorFacturaD)-[r3:INCLUYE]->(a:Articulo)
RETURN p.proveedor, COUNT(distinct a) as NúmeroProductos, collect(distinct a.descripcion)

//4.5. Crea un nodo cliente con tu nombre y apellido
CREATE (c:Cliente {Cliente:"Daniela Rodríguez"})

//RECOMENDACIONES
//5. Crea una recomendación de productos basada en tipo. Pruébala mostrando el producto que más sale del almacén 
MATCH (oat:ArticuloTipo)<-[]-(oa:Articulo)<-[]-(osd:SalidaD)-[]->(s:Salida)<-[]-(sd:SalidaD)-[]->(a:Articulo{descripcion:"THINNER AMERICANO "})-[]->(at:ArticuloTipo)
WHERE oa<>a AND (oa)-[:TIENE_UN]->(at)
RETURN at.descripcion, a.descripcion, oa.descripcion, oat.descripcion, COUNT(s.Id_Salida) AS Num
ORDER BY Num DESC, oa.descripcion
LIMIT 1

//6. Crea una recomendación de productos basada en grupo. Pruébala mostrando el producto que más sale del almacén
MATCH (oag:ArticuloGrupo)<-[]-(oa:Articulo)<-[]-(osd:SalidaD)-[]->(s:Salida)<-[]-(sd:SalidaD)-[]->(a:Articulo{descripcion:"THINNER AMERICANO "})-[]->(ag:ArticuloGrupo)
WHERE oa<>a AND (oa)-[:PERTENECE_A]->(ag)
RETURN ag.descripcion, a.descripcion, oa.descripcion, oag.descripcion, COUNT(s.Id_Salida) AS Num
ORDER BY Num DESC, oa.descripcion
LIMIT 1

//7. Crea una recomendación de productos basada en proveedor. Pruébala mostrando el producto que más sale del almacén
MATCH (op:Proveedor)-[]->(opf:ProveedorFactura)-[]->(opfd:ProveedorFacturaD)-[]->(oa:Articulo)<-[]-(osd:SalidaD)-[]->(s:Salida)<-[]-(sd:SalidaD)-[]->(a:Articulo{descripcion:"THINNER AMERICANO "})<-[]-(pfd:ProveedorFacturaD)<-[]-(pf:ProveedorFactura)<-[]-(p:Proveedor)
WHERE oa<>a AND (s)<-[:ES_PARTE_DE]-(osd)-[:CONTIENE]->(oa)<-[:INCLUYE]-(opfd)<-[:ENGLOBA]-(opf)<-[:GENERAN]-(p)
RETURN p.proveedor, a.descripcion, op.proveedor, oa.descripcion, 
ORDER BY Num DESC, oa.descripcion
LIMIT 1  

//8. Crea una recomendación de productos basada en color negro. Pruébala mostrando el producto que más sale del almacén.
MATCH (a:Articulo{Color_base:"Negro"})<-[:CONTIENE]-(sd:SalidaD)-[:ES_PARTE_DE]->(s:Salida)<-[:ES_PARTE_DE]-(osd:SalidaD)-[:CONTIENE]->(oa:Articulo)
WHERE oa<>a AND oa.Color_base = a.Color_base
RETURN a.Color_base, a.descripcion, oa.Color_base, oa.descripcion, count(s.Id_Salida) AS Num
ORDER BY Num DESC, oa.descripcion
LIMIT 1  

