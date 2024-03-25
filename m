Return-Path: <linux-s390+bounces-2739-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504488A316
	for <lists+linux-s390@lfdr.de>; Mon, 25 Mar 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AB71C39AF2
	for <lists+linux-s390@lfdr.de>; Mon, 25 Mar 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51916EC16;
	Mon, 25 Mar 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rzt8Ub0n"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB616AFD2;
	Mon, 25 Mar 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357476; cv=none; b=YmxPSqqpr2OnufUcgTKocfmEatYf3U3GgYZjLS6IZA86PngnkdfUkce6KUH6Gh1k03X2ps2fUji3i74eo77l9MM7cdfEtqlMGqOJVusndJlWXsQYjs5ZHQqYGm5G4HYjvAjOWf/Muf98TktP8fZkMoWpvQVsHonC2h505atCsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357476; c=relaxed/simple;
	bh=hLg+MEC+X+/hdN+QBVUp23lR2joIseTj5azKf9uV4Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0EXpSX1MTlfisQS1WPQaxNTVU3ujN9Dhut+bIGKOmCgsGlDuTXmJGNB5E+XV0g0YRGrWJFix2MGfyAJjsQSnXfFzHhv0uWzmUWrs8uZ07T0jzdK4L4yaMmEocz+V+2Ire/etIao44DrxfSuI6RYnXvbLATS0KtfvdRHkx6AooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rzt8Ub0n; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711357470; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=qLAlNAyNTH8roLSa1iZbljc2gfX6zDfIN+bjwNq5y50=;
	b=Rzt8Ub0nTcJbjfxIrk2MEfBwglc2jY6L+tlGz09vm7xLDgAvzo6tiSX3JyktrbFcs0O3FeFwiVglRyCSsGlQfFa+MBYeQ8U3D/hXdPrm19uQgcZKHcJHFeMiYin5NILvB8XpndXPUCLvpaOqYw7scBMXjKdUyPecNAw20cmrj08=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3DYlnJ_1711357467;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYlnJ_1711357467)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 17:04:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v5 6/6] virtio_ring: simplify the parameters of the funcs related to vring_create/new_virtqueue()
Date: Mon, 25 Mar 2024 17:04:19 +0800
Message-Id: <20240325090419.33677-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: f38b33f54e32
Content-Transfer-Encoding: 8bit

As the refactor of find_vqs()/vring_new_virtqueue()/vring_create_virtqueue
the struct cfg/tp_cfg are passed to vring.

This patch refactors the vring by these structures. This can simplify
the code.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 157 +++++++++++------------------------
 1 file changed, 50 insertions(+), 107 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 20e5e4779f36..70de1a9a81a3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -223,15 +223,11 @@ struct vring_virtqueue {
 #endif
 };
 
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
+					       unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev);
+					       struct vq_transport_config *tp_cfg,
+					       struct virtio_vq_config *cfg);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -240,6 +236,8 @@ static void vring_free(struct virtqueue *_vq);
  */
 
 #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
+#define cfg_vq_val(cfg, vq, key) (cfg->key[vq->vq.index])
+#define cfg_vq_get(cfg, vq, key) (cfg->key ? cfg_vq_val(cfg, vq, key) : false)
 
 static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
 				   unsigned int total_sg)
@@ -1138,32 +1136,28 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	return 0;
 }
 
-static struct virtqueue *vring_create_virtqueue_split(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name,
-	struct device *dma_dev)
+static struct virtqueue *vring_create_virtqueue_split(struct virtio_device *vdev,
+						      unsigned int index,
+						      struct vq_transport_config *tp_cfg,
+						      struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	int err;
 
-	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
-				      may_reduce_num, dma_dev);
+	tp_cfg->dma_dev = tp_cfg->dma_dev ? : vdev->dev.parent;
+
+	err = vring_alloc_queue_split(&vring_split, vdev,
+				      tp_cfg->num,
+				      tp_cfg->vring_align,
+				      tp_cfg->may_reduce_num,
+				      tp_cfg->dma_dev);
 	if (err)
 		return NULL;
 
-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
-				   context, notify, callback, name, dma_dev);
+	vq = __vring_new_virtqueue(vdev, index, &vring_split, tp_cfg, cfg);
 	if (!vq) {
-		vring_free_split(&vring_split, vdev, dma_dev);
+		vring_free_split(&vring_split, vdev, tp_cfg->dma_dev);
 		return NULL;
 	}
 
@@ -2050,38 +2044,33 @@ static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
 	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
 }
 
-static struct virtqueue *vring_create_virtqueue_packed(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name,
-	struct device *dma_dev)
+static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vdev,
+						       unsigned int index,
+						       struct vq_transport_config *tp_cfg,
+						       struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct vring_virtqueue *vq;
+	struct device *dma_dev;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
+	dma_dev = tp_cfg->dma_dev ? : vdev->dev.parent;
+
+	if (vring_alloc_queue_packed(&vring_packed, vdev, tp_cfg->num, dma_dev))
 		goto err_ring;
 
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
 		goto err_vq;
 
-	vq->vq.callback = callback;
+	vq->vq.callback = cfg_vq_val(cfg, vq, callbacks);
 	vq->vq.vdev = vdev;
-	vq->vq.name = name;
+	vq->vq.name = cfg_vq_val(cfg, vq, names);
 	vq->vq.index = index;
 	vq->vq.reset = false;
 	vq->we_own_ring = true;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
+	vq->notify = tp_cfg->notify;
+	vq->weak_barriers = tp_cfg->weak_barriers;
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	vq->broken = true;
 #else
@@ -2094,7 +2083,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
+		!cfg_vq_get(cfg, vq, ctx);
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
@@ -2104,9 +2093,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (err)
 		goto err_state_extra;
 
-	virtqueue_vring_init_packed(&vring_packed, !!callback);
+	virtqueue_vring_init_packed(&vring_packed, !!cfg_vq_val(cfg, vq, callbacks));
 
-	virtqueue_init(vq, num);
+	virtqueue_init(vq, tp_cfg->num);
 	virtqueue_vring_attach_packed(vq, &vring_packed);
 
 	spin_lock(&vdev->vqs_list_lock);
@@ -2599,15 +2588,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
+					       unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev)
+					       struct vq_transport_config *tp_cfg,
+					       struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -2620,26 +2605,26 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		return NULL;
 
 	vq->packed_ring = false;
-	vq->vq.callback = callback;
+	vq->vq.callback = cfg_vq_val(cfg, vq, callbacks);
 	vq->vq.vdev = vdev;
-	vq->vq.name = name;
+	vq->vq.name = cfg_vq_val(cfg, vq, names);
 	vq->vq.index = index;
 	vq->vq.reset = false;
 	vq->we_own_ring = false;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
+	vq->notify = tp_cfg->notify;
+	vq->weak_barriers = tp_cfg->weak_barriers;
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	vq->broken = true;
 #else
 	vq->broken = false;
 #endif
-	vq->dma_dev = dma_dev;
+	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
 	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
+		!cfg_vq_get(cfg, vq, ctx);
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
@@ -2667,36 +2652,10 @@ struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
 					 struct vq_transport_config *tp_cfg,
 					 struct virtio_vq_config *cfg)
 {
-	struct device *dma_dev;
-	unsigned int num;
-	unsigned int vring_align;
-	bool weak_barriers;
-	bool may_reduce_num;
-	bool context;
-	bool (*notify)(struct virtqueue *_);
-	void (*callback)(struct virtqueue *_);
-	const char *name;
-
-	dma_dev = tp_cfg->dma_dev ? : vdev->dev.parent;
-
-	num            = tp_cfg->num;
-	vring_align    = tp_cfg->vring_align;
-	weak_barriers  = tp_cfg->weak_barriers;
-	may_reduce_num = tp_cfg->may_reduce_num;
-	notify         = tp_cfg->notify;
-
-	name     = cfg->names[index];
-	callback = cfg->callbacks[index];
-	context  = cfg->ctx ? cfg->ctx[index] : false;
-
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return vring_create_virtqueue_packed(index, num, vring_align,
-				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, dma_dev);
+		return vring_create_virtqueue_packed(vdev, index, tp_cfg, cfg);
 
-	return vring_create_virtqueue_split(index, num, vring_align,
-			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, dma_dev);
+	return vring_create_virtqueue_split(vdev, index, tp_cfg, cfg);
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
@@ -2842,30 +2801,14 @@ struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
 				      struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue_split vring_split = {};
-	unsigned int num;
-	unsigned int vring_align;
-	bool weak_barriers;
-	bool context;
-	bool (*notify)(struct virtqueue *_);
-	void (*callback)(struct virtqueue *_);
-	const char *name;
-
-	num            = tp_cfg->num;
-	vring_align    = tp_cfg->vring_align;
-	weak_barriers  = tp_cfg->weak_barriers;
-	notify         = tp_cfg->notify;
-
-	name     = cfg->names[index];
-	callback = cfg->callbacks[index];
-	context  = cfg->ctx ? cfg->ctx[index] : false;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
 
-	vring_init(&vring_split.vring, num, pages, vring_align);
-	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
-				     context, notify, callback, name,
-				     vdev->dev.parent);
+	tp_cfg->dma_dev = vdev->dev.parent;
+
+	vring_init(&vring_split.vring, tp_cfg->num, pages, tp_cfg->vring_align);
+	return __vring_new_virtqueue(vdev, index, &vring_split, tp_cfg, cfg);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-- 
2.32.0.3.g01195cf9f


