shader_type canvas_item;

varying flat vec2 vertexPos;
uniform vec2 globalMousePos;

void vertex() {
    // Transform each vertex to isometric space
    vertexPos = (MODEL_MATRIX * vec4(VERTEX.x - VERTEX.y, (VERTEX.x + VERTEX.y) / 2.0, 0.0, 1.0)).xy;
}

void fragment() {
    // Transform mouse position to isometric space
    vec2 isoMousePos = vec2(
        (globalMousePos.x - globalMousePos.y) - 8.,
        ((globalMousePos.x + globalMousePos.y) / 2.0) - 16.
    );

    // Calculate distance between fragment and mouse position
    float distanceToMouse = length(vertexPos - isoMousePos);

    float tileSize = 64.0;

    // Check if the fragment is within a certain distance from the mouse position

    float isWithinX = step(16., tileSize * 0.5 - abs(isoMousePos.x - vertexPos.x));
    float isWithinY = step(16., tileSize * 0.5 - abs(isoMousePos.y - vertexPos.y));

    float isWithin = isWithinX * isWithinY;
    
    // Mix between texture color and highlight color based on the distance to mouse
    vec4 textureColor = texture(TEXTURE, UV);
    vec4 highlightColor = vec4(0.7, 0.0, 0.0, 0.7); // Adjust highlight color as needed
    COLOR = mix(textureColor, highlightColor, isWithin);
}
