/** Reduce la foto a ~800 px y la devuelve como data URL (la evidencia se guarda en la tabla, sin Storage). */
export function reducir(file: File): Promise<string> {
  return new Promise((res, rej) => {
    const r = new FileReader();
    r.onerror = () => rej(new Error("No se pudo leer la imagen"));
    r.onload = () => {
      const img = new Image();
      img.onload = () => {
        const k = Math.min(1, 800 / Math.max(img.width, img.height));
        const c = document.createElement("canvas");
        c.width = img.width * k; c.height = img.height * k;
        c.getContext("2d")!.drawImage(img, 0, 0, c.width, c.height);
        res(c.toDataURL("image/jpeg", 0.7));
      };
      img.onerror = () => rej(new Error("Imagen no válida"));
      img.src = String(r.result);
    };
    r.readAsDataURL(file);
  });
}
