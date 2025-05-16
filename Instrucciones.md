# Instrucciones para instalarlo y correrlo

## Modificaciones al original

- Tuve que modificar el setup completamente. El `requirements.txt` original no funcionaba para nada. Cree un `environment.yml` para instalar las cosas con `conda` directamente y no con `pip` (aunque no me gusta para nada `conda` y probablemente en el futuro trate de que funciones con `pipenv`).
- Cambié un poco el código de `demo.py` para que sea un poco más verbose con los errores.

## Cómo instalar todo

- Hay que seguir los pasos del setup original, usando los `.sh` que están en la carpeta `setup/`.
- Hay que bajarse el dataset de [acá](https://drive.google.com/drive/folders/1KmHNuExz-BCUhqW72x9n42WY186eZLie) y descomprimirlo en la carpeta `datasets/HDTF_TFHP/lmdb/`.
- Hay que descomprimir los `.zip` que aparecen en la carpeta `models/data/` después de correr `setup/fetch_data.sh`.
- El peor paso: hay que clonar el [repo](https://github.com/MPI-IS/mesh) pero no la versión orignal porque como todo lo que está hecho en python **tampoco funciona**. Hay que modificar el `Makefile` para que use bien `pip` por alguna razón. La 3er línea del target `all` tiene que ser:
    ```makefile	
    @python setup.py install --boost-location=$$BOOST_INCLUDE_DIRS --verbose
    ```
- Después de eso, hay que buildearlo: `$ BOOST_INCLUDE_DIRS=/path/to/boost/include make all`
- Una vez buildeado, **y asegurándose de estar en el conda enviroment de diffposetalk** hay que correr `pip install .`
- Ahora sí, finalmente, podemos correr el `demo.py` como dice el README original:
    ```shell
    python demo.py --exp_name head-SA-hubert-WM --iter 110000 -a demo/input/audio/FAST.flac -c demo/input/coef/TH217.npy -s demo/input/style/TH217.npy -o TH217-FAST-TH217.mp4 -n 3 -ss 3 -sa 1.15 -dtr 0.99
    ```


## Aclaración

Si se corre desde WSL o algún headless, antes de `demo.py...` hay que poner: `xvfb-run -s "-screen 0 640x480x24" ...` para que funcione el display. Si no, no va a funcionar. Y es muy probable que haya que tocar el acceso a `/dev/dri/renderD128`. También puede hacer falta instalar osmesa: `sudo apt-get install libgl1-mesa-dri libosmesa6 libosmesa6-dev`