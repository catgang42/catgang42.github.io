package net.minecraft.src;
// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.

// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) braces deadcode 

public class ModelCreeper extends ModelBase {

	public ModelCreeper() {
		float f = 0.0F;
		int i = 4;
		head = new ModelRenderer(0, 0);
		head.addBox(-4F, -8F, -4F, 8, 8, 8, f);
		head.setPosition(0.0F, i, 0.0F);
		field_1270_b = new ModelRenderer(32, 0);
		field_1270_b.addBox(-4F, -8F, -4F, 8, 8, 8, f + 0.5F);
		field_1270_b.setPosition(0.0F, i, 0.0F);
		body = new ModelRenderer(16, 16);
		body.addBox(-4F, 0.0F, -2F, 8, 12, 4, f);
		body.setPosition(0.0F, i, 0.0F);
		leg1 = new ModelRenderer(0, 16);
		leg1.addBox(-2F, 0.0F, -2F, 4, 6, 4, f);
		leg1.setPosition(-2F, 12 + i, 4F);
		leg2 = new ModelRenderer(0, 16);
		leg2.addBox(-2F, 0.0F, -2F, 4, 6, 4, f);
		leg2.setPosition(2.0F, 12 + i, 4F);
		leg3 = new ModelRenderer(0, 16);
		leg3.addBox(-2F, 0.0F, -2F, 4, 6, 4, f);
		leg3.setPosition(-2F, 12 + i, -4F);
		leg4 = new ModelRenderer(0, 16);
		leg4.addBox(-2F, 0.0F, -2F, 4, 6, 4, f);
		leg4.setPosition(2.0F, 12 + i, -4F);
	}

	public void render(float f, float f1, float f2, float f3, float f4, float f5) {
		setRotationAngles(f, f1, f2, f3, f4, f5);
		head.render(f5);
		body.render(f5);
		leg1.render(f5);
		leg2.render(f5);
		leg3.render(f5);
		leg4.render(f5);
	}

	public void setRotationAngles(float f, float f1, float f2, float f3, float f4, float f5) {
		head.rotateAngleY = f3 / 57.29578F;
		head.rotateAngleX = f4 / 57.29578F;
		leg1.rotateAngleX = MathHelper.cos(f * 0.6662F) * 1.4F * f1;
		leg2.rotateAngleX = MathHelper.cos(f * 0.6662F + 3.141593F) * 1.4F * f1;
		leg3.rotateAngleX = MathHelper.cos(f * 0.6662F + 3.141593F) * 1.4F * f1;
		leg4.rotateAngleX = MathHelper.cos(f * 0.6662F) * 1.4F * f1;
	}

	public ModelRenderer head;
	public ModelRenderer field_1270_b;
	public ModelRenderer body;
	public ModelRenderer leg1;
	public ModelRenderer leg2;
	public ModelRenderer leg3;
	public ModelRenderer leg4;
}
