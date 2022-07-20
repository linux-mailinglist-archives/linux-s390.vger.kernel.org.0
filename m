Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39C57AED8
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jul 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiGTDHp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Jul 2022 23:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbiGTDGk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 23:06:40 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BC70E43;
        Tue, 19 Jul 2022 20:05:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0VJuvIdk_1658286319;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VJuvIdk_1658286319)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 11:05:20 +0800
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
Subject: [PATCH v12 18/40] virtio_ring: packed: extract the logic of attach vring
Date:   Wed, 20 Jul 2022 11:04:14 +0800
Message-Id: <20220720030436.79520-19-xuanzhuo@linux.alibaba.com>
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

Separate the logic of attach vring, the subsequent patch will call it
separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1f8d6417b46a..19ed20d7d433 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1932,6 +1932,22 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_p
 	return -ENOMEM;
 }
 
+static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
+					  struct vring_virtqueue_packed *vring_packed)
+{
+	vq->packed.ring_dma_addr = vring_packed->ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring_packed->driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring_packed->device_event_dma_addr;
+
+	vq->packed.ring_size_in_bytes = vring_packed->ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring_packed->event_size_in_bytes;
+
+	vq->packed.vring = vring_packed->vring;
+
+	vq->packed.desc_state = vring_packed->desc_state;
+	vq->packed.desc_extra = vring_packed->desc_extra;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1972,15 +1988,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 
-	vq->packed.ring_dma_addr = vring_packed.ring_dma_addr;
-	vq->packed.driver_event_dma_addr = vring_packed.driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = vring_packed.device_event_dma_addr;
-
-	vq->packed.ring_size_in_bytes = vring_packed.ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = vring_packed.event_size_in_bytes;
-
-	vq->packed.vring = vring_packed.vring;
-
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
@@ -1990,10 +1997,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (err)
 		goto err_state_extra;
 
-	vq->packed.desc_state = vring.desc_state;
-	vq->packed.desc_extra = vring.desc_extra;
-
 	virtqueue_init(vq, num);
+	virtqueue_vring_attach_packed(vq, &vring_packed);
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
-- 
2.31.0

