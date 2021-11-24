LARGURA_TELA = 560
ALTURA_TELA = 560
MAX_bombas = 12
FIM_JOGO = false
BOMBA_ATINGIDOS = 0
BOMBA_OBJETIVO = 100

aviao = {
    src = "imagens/aviao.png",
    largura = 40,
    altura = 40,
    x = LARGURA_TELA/2 - 64/2,
    y = ALTURA_TELA - 64/2,
    tiros = {}
}

bombas = {}

function daTiro()
    disparo:play()
    local tiro = {
        x = aviao.x + aviao.largura/2,
        y = aviao.y,
        largura = 8,
        altura = 8
    }
    table.insert(aviao.tiros, tiro)
end

function moveTiros()
    for i = #aviao.tiros, 1, -1 do
        if aviao.tiros[i].y > 0 then
            aviao.tiros[i].y = aviao.tiros[i].y - 15
        else
            table.remove(aviao.tiros, i)
        end
    end
end

function destroiAviao()
    destruicao:play()

    aviao.src = "imagens/boom.png"
    aviao.imagem = love.graphics.newImage(aviao.src)
    aviao.largura = 67
    aviao.altura = 77
end

function temColisao(X1, Y1, L1, A1, X2, Y2, L2, A2)
    return X2 < X1 + L1 and
           X1 < X2 + L2 and
           Y1 < Y2 + A2 and
           Y2 < Y1 + A1
end

function removeBombas()
    for i = #bombas, 1, -1 do
        if bombas[i].y > ALTURA_TELA then
            table.remove(bombas, i)
        end
    end
end

function criaBomba()
    bomba = {
        x = math.random(LARGURA_TELA),
        y = -70,
        largura = 50,
        altura = 44,
        peso = math.random(3),
        deslocamento_horizontal = math.random(-1, 1)
    }
    table.insert(bombas, bomba)
end

function moveBombas()
    for k, bomba in pairs(bombas) do
        bomba.y = bomba.y + bomba.peso
        bomba.x = bomba.x + bomba.deslocamento_horizontal
    end
end

function moveAviao()
    if love.keyboard.isDown('w') then
        aviao.y = aviao.y - 4
    end
    if love.keyboard.isDown('s') then
        aviao.y = aviao.y + 4
    end
    if love.keyboard.isDown('a') then
        aviao.x = aviao.x - 4
    end
    if love.keyboard.isDown('d') then
        aviao.x = aviao.x + 4
    end
end

function trocaMusicaDeFundo()
    musica_ambiente:stop()
    game_over:play()
end

function checaColisaoComAviao()
    for k, bomba in pairs(bombas) do
        if temColisao(bomba.x, bomba.y, bomba.largura, bomba.altura, 
                        aviao.x, aviao.y, aviao.largura, aviao.altura) then
            trocaMusicaDeFundo()
            destroiAviao()
            FIM_JOGO = true
        end
    end
end

function checaColisaoComTiros()
    for i = #aviao.tiros, 1, -1 do
        for j = #bombas, 1, -1 do
            if temColisao(aviao.tiros[i].x, aviao.tiros[i].y, aviao.tiros[i].largura, aviao.tiros[i].altura, 
                            bombas[j].x, bombas[j].y, bombas[j].largura, bombas[j].altura) then
                BOMBA_ATINGIDOS = BOMBA_ATINGIDOS + 1
                table.remove(aviao.tiros, i)
                table.remove(bombas, j)
                break
            end
        end
    end
end

function checaColisoes()
    checaColisaoComAviao()
    checaColisaoComTiros()
end

function checaObjetivoConcluido()
    if BOMBA_ATINGIDOS >= BOMBA_OBJETIVO then
        musica_ambiente:stop()
        VENCEDOR = true
        vencedor_som:play()
    end
end    

function love.load()
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, {resizable = false})
    love.window.setTitle("Shooter")

    math.randomseed(os.time())

    background = love.graphics.newImage("imagens/ceu.png")
    gameover_img = love.graphics.newImage("imagens/game_over.png")
    vencedor_img = love.graphics.newImage("imagens/venceu.png")

    aviao.imagem = love.graphics.newImage(aviao.src)
    bomba_img = love.graphics.newImage("imagens/bomba.png")
    tiro_img = love.graphics.newImage("imagens/bala.png")

    musica_ambiente = love.audio.newSource("audios/ambiente.wav", "static")
    musica_ambiente:setLooping(true)
    musica_ambiente:play()

    destruicao = love.audio.newSource("audios/destruicao.wav", "static")
    game_over = love.audio.newSource("audios/game_over.wav", "static")
    vencedor_som = love.audio.newSource("audios/winner.wav", "static")
    disparo = love.audio.newSource("audios/disparo.wav", "static")
end

function love.update(dt)
    if not FIM_JOGO and not VENCEDOR then
        if love.keyboard.isDown('w', 'a', 's', 'd') then
            moveAviao()
        end

        removeBombas()
        if #bombas < MAX_bombas then
            criaBomba()
        end
        moveBombas()
        moveTiros()
        checaColisoes()
        checaObjetivoConcluido()
    end
end

function love.keypressed(tecla)
    if tecla == "escape" then
        love.event.quit()
    elseif tecla == "space" then
        daTiro()
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(aviao.imagem, aviao.x, aviao.y)
    
    love.graphics.print("Score: "..BOMBA_OBJETIVO-BOMBA_ATINGIDOS,0,0)

    for k, bomba in pairs(bombas) do
        love.graphics.draw(bomba_img, bomba.x, bomba.y) 
    end

    for k, tiro in pairs(aviao.tiros) do
        love.graphics.draw(tiro_img, tiro.x, tiro.y) 
    end

    if FIM_JOGO then
        love.graphics.draw(gameover_img, LARGURA_TELA/2 - gameover_img:getWidth()/2, ALTURA_TELA/2 - gameover_img:getHeight()/2)
    end   
    
    if VENCEDOR then
        love.graphics.draw(vencedor_img, LARGURA_TELA/2 - vencedor_img:getWidth()/2, ALTURA_TELA/2 - vencedor_img:getHeight()/2)
    end
end