Return-Path: <linux-s390+bounces-2069-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1073860C72
	for <lists+linux-s390@lfdr.de>; Fri, 23 Feb 2024 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AC5B25F3F
	for <lists+linux-s390@lfdr.de>; Fri, 23 Feb 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4F2C18D;
	Fri, 23 Feb 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EhEe0RLk"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E42208A;
	Fri, 23 Feb 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676866; cv=none; b=qSTrGDPAMvw16+EOEV4Oe4ymS563UKhi4SUS3LIUo0x9skhiAIPlpRBW9ZpWR08d1A2T/0AjG60dxMjIIq2JLkXcEBqKqOK5OBeSf7HhQsFgF5p4rw/E2b8iwIX1UUbx/wwDpWSnUObWplWdFxCETdyONk8sDqhr+6wwuKvP4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676866; c=relaxed/simple;
	bh=evlgRHodcZps3pWynlLYjgKtTZVMPuPLf69EUhOF3pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+3Uw3IsLYePsw5DSNKj5R8j80V2g2L6NEWqedaDbj49GYL6OvFt3E+2knbwxWFeGwMQhIzK/C29CFdLlm/of+c9LaDEI3mtLCYPQLIwwucEfbxsarvbaZeIzCbsMv0g6yZzSyudWqUqMeuzc6eQ1yJzGhkkyWhoD2+3hI7v7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EhEe0RLk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708676855; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MEVtA8vb6lj50l3aO2/I3wlv6226v1gV9tFg60hG/lc=;
	b=EhEe0RLkOYKkNd2KX9b8DkYxmlIEohT5aGdxz38ppyaE3Qsjq6/7/7nCTXNgzlIG/wf8Pwuz/LxuAuUdtGQPtDXKxh86qZCPbR76aL9rjK6kFAm113Mb7MO+a5qqSygCXqI+zLwC/SXrtbdWwBj2MR3m9gZYw2lpB4tXLp4jBXU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W13gV2p_1708676851;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13gV2p_1708676851)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:27:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v2 03/19] virtio_ring: packed: structure the indirect desc table
Date: Fri, 23 Feb 2024 16:27:10 +0800
Message-Id: <20240223082726.52915-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 510995f33855
Content-Transfer-Encoding: 8bit

This commit structure the indirect desc table.
Then we can get the desc num directly when doing unmap.

And save the dma info to the struct, then the indirect
will not use the dma fields of the desc_extra. The subsequent
commits will make the dma fields are optional. But for
the indirect case, we must record the dma info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 98d27dfdcf16..2d4d1417a1d6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -72,9 +72,16 @@ struct vring_desc_state_split {
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
 };
 
+struct vring_packed_desc_indir {
+	dma_addr_t addr;		/* Descriptor Array DMA addr. */
+	u32 len;			/* Descriptor Array length. */
+	u32 num;
+	struct vring_packed_desc desc[];
+};
+
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_packed_desc_indir *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1249,10 +1256,13 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
+static struct vring_packed_desc_indir *alloc_indirect_packed(unsigned int total_sg,
 						       gfp_t gfp)
 {
-	struct vring_packed_desc *desc;
+	struct vring_packed_desc_indir *in_desc;
+	u32 size;
+
+	size = struct_size(in_desc, desc, total_sg);
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1261,9 +1271,10 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
 
-	return desc;
+	in_desc = kmalloc(size, gfp);
+
+	return in_desc;
 }
 
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
@@ -1274,6 +1285,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_packed_desc_indir *in_desc;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1281,10 +1293,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
-	if (!desc)
+	in_desc = alloc_indirect_packed(total_sg, gfp);
+	if (!in_desc)
 		return -ENOMEM;
 
+	desc = in_desc->desc;
+
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
 		kfree(desc);
@@ -1321,17 +1335,19 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		goto unmap_release;
 	}
 
+	if (vring_need_unmap_buffer(vq))
+		in_desc->num = i;
+
+	if (vq->use_dma_api) {
+		in_desc->addr = addr;
+		in_desc->len = total_sg * sizeof(struct vring_packed_desc);
+	}
+
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);
 
-	if (vq->use_dma_api) {
-		vq->packed.desc_extra[id].addr = addr;
-		vq->packed.desc_extra[id].len = total_sg *
-				sizeof(struct vring_packed_desc);
-	}
-
 	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
 		vq->packed.avail_used_flags;
 
@@ -1362,7 +1378,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir_desc = in_desc;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1381,7 +1397,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		vring_unmap_desc_packed(vq, &desc[i]);
 
 free_desc:
-	kfree(desc);
+	kfree(in_desc);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -1595,7 +1611,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
-	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 	u16 flags;
 
@@ -1622,27 +1637,22 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (ctx)
 			*ctx = state->indir_desc;
 	} else {
-		const struct vring_desc_extra *extra;
-		u32 len;
+		struct vring_packed_desc_indir *in_desc;
+
+		in_desc = state->indir_desc;
 
 		if (vq->use_dma_api) {
-			extra = &vq->packed.desc_extra[id];
 			dma_unmap_single(vring_dma_dev(vq),
-					 extra->addr, extra->len,
+					 in_desc->addr, in_desc->len,
 					 (flags & VRING_DESC_F_WRITE) ?
 					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 
-		/* Free the indirect table, if any, now that it's unmapped. */
-		desc = state->indir_desc;
-
 		if (vring_need_unmap_buffer(vq)) {
-			len = vq->packed.desc_extra[id].len;
-			for (i = 0; i < len / sizeof(struct vring_packed_desc);
-					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+			for (i = 0; i < in_desc->num; i++)
+				vring_unmap_desc_packed(vq, &in_desc->desc[i]);
 		}
-		kfree(desc);
+		kfree(in_desc);
 		state->indir_desc = NULL;
 	}
 }
-- 
2.32.0.3.g01195cf9f


