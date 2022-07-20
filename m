Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4357AF0E
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jul 2022 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiGTDII (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Jul 2022 23:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbiGTDGz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 23:06:55 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC971BD3;
        Tue, 19 Jul 2022 20:05:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0VJuw0Wb_1658286329;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VJuw0Wb_1658286329)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 11:05:30 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
Subject: [PATCH v12 22/40] virtio_ring: introduce virtqueue_resize()
Date:   Wed, 20 Jul 2022 11:04:18 +0800
Message-Id: <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 366032b2ffac
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Introduce virtqueue_resize() to implement the resize of vring.
Based on these, the driver can dynamically adjust the size of the vring.
For example: ethtool -G.

virtqueue_resize() implements resize based on the vq reset function. In
case of failure to allocate a new vring, it will give up resize and use
the original vring.

During this process, if the re-enable reset vq fails, the vq can no
longer be used. Although the probability of this situation is not high.

The parameter recycle is used to recycle the buffer that is no longer
used.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b092914e9dcd..cf4379175163 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2545,6 +2545,75 @@ struct virtqueue *vring_create_virtqueue(
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
+/**
+ * virtqueue_resize - resize the vring of vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @num: new ring num
+ * @recycle: callback for recycle the useless buffer
+ *
+ * When it is really necessary to create a new vring, it will set the current vq
+ * into the reset state. Then call the passed callback to recycle the buffer
+ * that is no longer used. Only after the new vring is successfully created, the
+ * old vring will be released.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
+ *  vq can still work normally
+ * -EBUSY: Failed to sync with device, vq may not work properly
+ * -ENOENT: Transport or device not supported
+ * -E2BIG/-EINVAL: num error
+ * -EPERM: Operation not permitted
+ *
+ */
+int virtqueue_resize(struct virtqueue *_vq, u32 num,
+		     void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = vq->vq.vdev;
+	void *buf;
+	int err;
+
+	if (!vq->we_own_ring)
+		return -EPERM;
+
+	if (num > vq->vq.num_max)
+		return -E2BIG;
+
+	if (!num)
+		return -EINVAL;
+
+	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
+		return 0;
+
+	if (!vdev->config->disable_vq_and_reset)
+		return -ENOENT;
+
+	if (!vdev->config->enable_vq_after_reset)
+		return -ENOENT;
+
+	err = vdev->config->disable_vq_and_reset(_vq);
+	if (err)
+		return err;
+
+	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
+		recycle(_vq, buf);
+
+	if (vq->packed_ring)
+		err = virtqueue_resize_packed(_vq, num);
+	else
+		err = virtqueue_resize_split(_vq, num);
+
+	if (vdev->config->enable_vq_after_reset(_vq))
+		return -EBUSY;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtqueue_resize);
+
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 129bde7521e3..62e31bca5602 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
+int virtqueue_resize(struct virtqueue *vq, u32 num,
+		     void (*recycle)(struct virtqueue *vq, void *buf));
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
2.31.0

