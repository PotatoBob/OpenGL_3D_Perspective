#version 330 core

in vec3 position;
in vec2 texCoord;
in vec3 normal;

uniform mat4 modelMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;

out vec2 textureCoordinate;
out vec3 fragmentPosition;
out vec3 normalCoords;
out vec3 viewCoords;

void main(){
    fragmentPosition = vec3(modelMatrix * vec4(position, 0.0));
    normalCoords = mat3(transpose(modelMatrix)) * normal;  
    textureCoordinate = texCoord;
    viewCoords.x = viewMatrix[3][0];
    viewCoords.y = viewMatrix[3][1];
    viewCoords.z = viewMatrix[3][2];
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1);
}