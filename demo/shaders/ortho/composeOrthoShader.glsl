/*
 * Proland: a procedural landscape rendering library.
 * Copyright (c) 2008-2011 INRIA
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Proland is distributed under a dual-license scheme.
 * You can obtain a specific license from Inria: proland-licensing@inria.fr.
 */

/*
 * Authors: Eric Bruneton, Antoine Begault, Guillaume Piolat.
 */

uniform sampler2D sourceSampler;
uniform sampler2D brushSampler;
uniform vec4 brushColor;

#ifdef _VERTEX_

layout(location=0) in vec4 vertex;
out vec2 st;

void main() {
    gl_Position = vec4(vertex.xy, 0.0, 1.0);
    st = vertex.xy * 0.5 + vec2(0.5);
}

#endif

#ifdef _FRAGMENT_

layout(location=0) out vec4 data;
in vec2 st;

void main() {
    vec4 src = textureLod(sourceSampler, st, 0.0);
    vec4 brush = textureLod(brushSampler, st, 0.0);
    data = brushColor * brush + (1.0 - brush.x * brushColor.a) * src;
}

#endif
