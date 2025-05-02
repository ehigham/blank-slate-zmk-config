default:
    @just --list


board := 'lpgalaxy_blank_slate'    
config := absolute_path('config')


init:
    west init -l "{{ config }}"
    @just update
    west zephyr-export


build:
    west build zmk/app \
        --pristine \
        --build-dir ".build/{{ board }}" \
        --board {{ board }} \
        -DZMK_CONFIG="{{ config }}"

    mkdir -p "firmware"
    cp -T ".build/{{ board }}/zephyr/zmk.uf2" "firmware/{{ board }}.uf2"

flash:
    west flash -d ".build/{{ board }}"

update:
    west update --fetch-opt=--filter=blob:none

    
clean:
    rm -rf .build firmware


purge:
    @just clean
    rm -rf .west modules zmk zephyr 
