Return-Path: <linux-s390+bounces-1545-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A058284CCD6
	for <lists+linux-s390@lfdr.de>; Wed,  7 Feb 2024 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D903E1F24C28
	for <lists+linux-s390@lfdr.de>; Wed,  7 Feb 2024 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3B7E762;
	Wed,  7 Feb 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6SoiiTL"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FD7764E;
	Wed,  7 Feb 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316478; cv=none; b=WNc96PvFojBlUFerMLiL43R2RvAZySMrF+OgfrCSwX0mVvVpHBVR5O9+cLP6pTfEUT6BIp5FyXc3RYlaDzC14H0KslZMJbqFHo4m7hL/JUxyqM0CT6h03eNQOZzycu2KKdpYThQxQBpC9GzuUMsjBYhU6ZtUWAJ1pxInWcjtRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316478; c=relaxed/simple;
	bh=N8vmxt/9k7RpYh3QR6JhUsLC61eTt/uyhaXRvnXJenA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhBTxwZEe5f+jfsDZsDdwZilp5p832Vp2B7l0EPOCjHHxJ460CvxkrrNcqrmz52+eMcBM+75AjDZg+Ldc3KBYnPiUT8fe27X5dXeP0Urg8TAwXynQhtdio+hEXEvYKtgwPsuF0XoNFEJLXx2grKJ+9wJ9wntqjylePQrr/pDidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6SoiiTL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417EWf1J021497;
	Wed, 7 Feb 2024 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5hWoTM+PVEp40fFMjHaflMlt9ECkP8VaL7vJ0EV+ENg=;
 b=h6SoiiTL6+lWmBDASZFgmpPriItsHu9Jy3G+qzs1kDXIN5W8vH8DPM8GeKVWtn7O14LE
 tzLGqS0AKefVm0EXQ0KSOIFXAAuagP3eXg8PUYK/gFwKpGHPdILwl7yJ1GuBOBmvkgzd
 cxrOkIFPku27CYYoKsX+I4NwYNI+/od/M9qrWy67JwvlCs5uxh8YnVUTxno9g8Bx4/lg
 q0a1Tv5amNpp3BRwJENS4skhjpRu5tcsADTzX4Ru1OC5hVZ8+XqRFxeqzW6+/myr7dAV
 4yEx697HvACDV4Oj85Lty0LE5ISBDCeDM1ZQyBOcOVyhaF7W5AaT8csQD7+RdWcQPfff lA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4bqa813h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:33:41 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417EX8DI024019;
	Wed, 7 Feb 2024 14:33:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4bqa812m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:33:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 417C7LOl008539;
	Wed, 7 Feb 2024 14:33:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221k5v6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:33:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 417EXbv619595876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 14:33:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B047D58054;
	Wed,  7 Feb 2024 14:33:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B1E458045;
	Wed,  7 Feb 2024 14:33:29 +0000 (GMT)
Received: from [9.61.84.204] (unknown [9.61.84.204])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 14:33:29 +0000 (GMT)
Message-ID: <3e38c1cf-6d40-4d8b-8275-f001b4cdc543@linux.ibm.com>
Date: Wed, 7 Feb 2024 09:33:28 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] eventfd: simplify eventfd_signal()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Oded Gabbay <ogabbay@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan
 <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fpga@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-aio@kvack.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
 <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>
 <CAJSP0QU1vd8hCacTYA0wiQyGYnshAQd2bTGr80zckF626-WU+A@mail.gmail.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <CAJSP0QU1vd8hCacTYA0wiQyGYnshAQd2bTGr80zckF626-WU+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t_LczAjQm5qMyGhVpmwzTgaPAJPOADmg
X-Proofpoint-ORIG-GUID: LZIhtyTgHuzhLYJj8zT_RfbxugeptSxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070108

For vfio_ap_ops.c

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

On 2/6/24 2:44 PM, Stefan Hajnoczi wrote:
> vhost and VIRTIO-related parts:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> On Wed, 22 Nov 2023 at 07:50, Christian Brauner <brauner@kernel.org> wrote:
>> Ever since the evenfd type was introduced back in 2007 in commit
>> e1ad7468c77d ("signal/timer/event: eventfd core") the eventfd_signal()
>> function only ever passed 1 as a value for @n. There's no point in
>> keeping that additional argument.
>>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> ---
>>   arch/x86/kvm/hyperv.c                     |  2 +-
>>   arch/x86/kvm/xen.c                        |  2 +-
>>   drivers/accel/habanalabs/common/device.c  |  2 +-
>>   drivers/fpga/dfl.c                        |  2 +-
>>   drivers/gpu/drm/drm_syncobj.c             |  6 +++---
>>   drivers/gpu/drm/i915/gvt/interrupt.c      |  2 +-
>>   drivers/infiniband/hw/mlx5/devx.c         |  2 +-
>>   drivers/misc/ocxl/file.c                  |  2 +-
>>   drivers/s390/cio/vfio_ccw_chp.c           |  2 +-
>>   drivers/s390/cio/vfio_ccw_drv.c           |  4 ++--
>>   drivers/s390/cio/vfio_ccw_ops.c           |  6 +++---
>>   drivers/s390/crypto/vfio_ap_ops.c         |  2 +-
>>   drivers/usb/gadget/function/f_fs.c        |  4 ++--
>>   drivers/vdpa/vdpa_user/vduse_dev.c        |  6 +++---
>>   drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |  2 +-
>>   drivers/vfio/pci/vfio_pci_core.c          |  6 +++---
>>   drivers/vfio/pci/vfio_pci_intrs.c         | 12 ++++++------
>>   drivers/vfio/platform/vfio_platform_irq.c |  4 ++--
>>   drivers/vhost/vdpa.c                      |  4 ++--
>>   drivers/vhost/vhost.c                     | 10 +++++-----
>>   drivers/vhost/vhost.h                     |  2 +-
>>   drivers/virt/acrn/ioeventfd.c             |  2 +-
>>   drivers/xen/privcmd.c                     |  2 +-
>>   fs/aio.c                                  |  2 +-
>>   fs/eventfd.c                              |  9 +++------
>>   include/linux/eventfd.h                   |  4 ++--
>>   mm/memcontrol.c                           | 10 +++++-----
>>   mm/vmpressure.c                           |  2 +-
>>   samples/vfio-mdev/mtty.c                  |  4 ++--
>>   virt/kvm/eventfd.c                        |  4 ++--
>>   30 files changed, 60 insertions(+), 63 deletions(-)
>>
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 238afd7335e4..4943f6b2bbee 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -2388,7 +2388,7 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
>>          if (!eventfd)
>>                  return HV_STATUS_INVALID_PORT_ID;
>>
>> -       eventfd_signal(eventfd, 1);
>> +       eventfd_signal(eventfd);
>>          return HV_STATUS_SUCCESS;
>>   }
>>
>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>> index e53fad915a62..523bb6df5ac9 100644
>> --- a/arch/x86/kvm/xen.c
>> +++ b/arch/x86/kvm/xen.c
>> @@ -2088,7 +2088,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
>>                  if (ret < 0 && ret != -ENOTCONN)
>>                          return false;
>>          } else {
>> -               eventfd_signal(evtchnfd->deliver.eventfd.ctx, 1);
>> +               eventfd_signal(evtchnfd->deliver.eventfd.ctx);
>>          }
>>
>>          *r = 0;
>> diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
>> index 9711e8fc979d..3a89644f087c 100644
>> --- a/drivers/accel/habanalabs/common/device.c
>> +++ b/drivers/accel/habanalabs/common/device.c
>> @@ -2044,7 +2044,7 @@ static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64
>>          notifier_event->events_mask |= event_mask;
>>
>>          if (notifier_event->eventfd)
>> -               eventfd_signal(notifier_event->eventfd, 1);
>> +               eventfd_signal(notifier_event->eventfd);
>>
>>          mutex_unlock(&notifier_event->lock);
>>   }
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index dd7a783d53b5..e73f88050f08 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -1872,7 +1872,7 @@ static irqreturn_t dfl_irq_handler(int irq, void *arg)
>>   {
>>          struct eventfd_ctx *trigger = arg;
>>
>> -       eventfd_signal(trigger, 1);
>> +       eventfd_signal(trigger);
>>          return IRQ_HANDLED;
>>   }
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 01da6789d044..b9cc62982196 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -1365,7 +1365,7 @@ static void syncobj_eventfd_entry_fence_func(struct dma_fence *fence,
>>          struct syncobj_eventfd_entry *entry =
>>                  container_of(cb, struct syncobj_eventfd_entry, fence_cb);
>>
>> -       eventfd_signal(entry->ev_fd_ctx, 1);
>> +       eventfd_signal(entry->ev_fd_ctx);
>>          syncobj_eventfd_entry_free(entry);
>>   }
>>
>> @@ -1388,13 +1388,13 @@ syncobj_eventfd_entry_func(struct drm_syncobj *syncobj,
>>          entry->fence = fence;
>>
>>          if (entry->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE) {
>> -               eventfd_signal(entry->ev_fd_ctx, 1);
>> +               eventfd_signal(entry->ev_fd_ctx);
>>                  syncobj_eventfd_entry_free(entry);
>>          } else {
>>                  ret = dma_fence_add_callback(fence, &entry->fence_cb,
>>                                               syncobj_eventfd_entry_fence_func);
>>                  if (ret == -ENOENT) {
>> -                       eventfd_signal(entry->ev_fd_ctx, 1);
>> +                       eventfd_signal(entry->ev_fd_ctx);
>>                          syncobj_eventfd_entry_free(entry);
>>                  }
>>          }
>> diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
>> index 9665876b4b13..7f4db438e400 100644
>> --- a/drivers/gpu/drm/i915/gvt/interrupt.c
>> +++ b/drivers/gpu/drm/i915/gvt/interrupt.c
>> @@ -454,7 +454,7 @@ static void inject_virtual_interrupt(struct intel_vgpu *vgpu)
>>                  return;
>>          if (!vgpu->msi_trigger)
>>                  return;
>> -       eventfd_signal(vgpu->msi_trigger, 1);
>> +       eventfd_signal(vgpu->msi_trigger);
>>   }
>>
>>   static void propagate_event(struct intel_gvt_irq *irq,
>> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
>> index 8ba53edf2311..869369cb5b5f 100644
>> --- a/drivers/infiniband/hw/mlx5/devx.c
>> +++ b/drivers/infiniband/hw/mlx5/devx.c
>> @@ -2498,7 +2498,7 @@ static void dispatch_event_fd(struct list_head *fd_list,
>>
>>          list_for_each_entry_rcu(item, fd_list, xa_list) {
>>                  if (item->eventfd)
>> -                       eventfd_signal(item->eventfd, 1);
>> +                       eventfd_signal(item->eventfd);
>>                  else
>>                          deliver_event(item, data);
>>          }
>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> index ac69b7f361f5..7eb74711ac96 100644
>> --- a/drivers/misc/ocxl/file.c
>> +++ b/drivers/misc/ocxl/file.c
>> @@ -184,7 +184,7 @@ static irqreturn_t irq_handler(void *private)
>>   {
>>          struct eventfd_ctx *ev_ctx = private;
>>
>> -       eventfd_signal(ev_ctx, 1);
>> +       eventfd_signal(ev_ctx);
>>          return IRQ_HANDLED;
>>   }
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
>> index d3f3a611f95b..38c176cf6295 100644
>> --- a/drivers/s390/cio/vfio_ccw_chp.c
>> +++ b/drivers/s390/cio/vfio_ccw_chp.c
>> @@ -115,7 +115,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>>
>>          /* Notify the guest if more CRWs are on our queue */
>>          if (!list_empty(&private->crw) && private->crw_trigger)
>> -               eventfd_signal(private->crw_trigger, 1);
>> +               eventfd_signal(private->crw_trigger);
>>
>>          return ret;
>>   }
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 43601816ea4e..bfb35cfce1ef 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -112,7 +112,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>>                  private->state = VFIO_CCW_STATE_IDLE;
>>
>>          if (private->io_trigger)
>> -               eventfd_signal(private->io_trigger, 1);
>> +               eventfd_signal(private->io_trigger);
>>   }
>>
>>   void vfio_ccw_crw_todo(struct work_struct *work)
>> @@ -122,7 +122,7 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>>          private = container_of(work, struct vfio_ccw_private, crw_work);
>>
>>          if (!list_empty(&private->crw) && private->crw_trigger)
>> -               eventfd_signal(private->crw_trigger, 1);
>> +               eventfd_signal(private->crw_trigger);
>>   }
>>
>>   /*
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index cba4971618ff..ea532a8a4a0c 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -421,7 +421,7 @@ static int vfio_ccw_mdev_set_irqs(struct vfio_ccw_private *private,
>>          case VFIO_IRQ_SET_DATA_NONE:
>>          {
>>                  if (*ctx)
>> -                       eventfd_signal(*ctx, 1);
>> +                       eventfd_signal(*ctx);
>>                  return 0;
>>          }
>>          case VFIO_IRQ_SET_DATA_BOOL:
>> @@ -432,7 +432,7 @@ static int vfio_ccw_mdev_set_irqs(struct vfio_ccw_private *private,
>>                          return -EFAULT;
>>
>>                  if (trigger && *ctx)
>> -                       eventfd_signal(*ctx, 1);
>> +                       eventfd_signal(*ctx);
>>                  return 0;
>>          }
>>          case VFIO_IRQ_SET_DATA_EVENTFD:
>> @@ -612,7 +612,7 @@ static void vfio_ccw_mdev_request(struct vfio_device *vdev, unsigned int count)
>>                                                 "Relaying device request to user (#%u)\n",
>>                                                 count);
>>
>> -               eventfd_signal(private->req_trigger, 1);
>> +               eventfd_signal(private->req_trigger);
>>          } else if (count == 0) {
>>                  dev_notice(dev,
>>                             "No device request channel registered, blocked until released by user\n");
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 4db538a55192..542b5be73a6a 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1794,7 +1794,7 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
>>                                                 "Relaying device request to user (#%u)\n",
>>                                                 count);
>>
>> -               eventfd_signal(matrix_mdev->req_trigger, 1);
>> +               eventfd_signal(matrix_mdev->req_trigger);
>>          } else if (count == 0) {
>>                  dev_notice(dev,
>>                             "No device request registered, blocked until released by user\n");
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index efe3e3b85769..fdd0fc7b8f25 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
>>          io_data->kiocb->ki_complete(io_data->kiocb, ret);
>>
>>          if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
>> -               eventfd_signal(io_data->ffs->ffs_eventfd, 1);
>> +               eventfd_signal(io_data->ffs->ffs_eventfd);
>>
>>          if (io_data->read)
>>                  kfree(io_data->to_free);
>> @@ -2738,7 +2738,7 @@ static void __ffs_event_add(struct ffs_data *ffs,
>>          ffs->ev.types[ffs->ev.count++] = type;
>>          wake_up_locked(&ffs->ev.waitq);
>>          if (ffs->ffs_eventfd)
>> -               eventfd_signal(ffs->ffs_eventfd, 1);
>> +               eventfd_signal(ffs->ffs_eventfd);
>>   }
>>
>>   static void ffs_event_add(struct ffs_data *ffs,
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 0ddd4b8abecb..6cb5ce4a8b9a 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -493,7 +493,7 @@ static void vduse_vq_kick(struct vduse_virtqueue *vq)
>>                  goto unlock;
>>
>>          if (vq->kickfd)
>> -               eventfd_signal(vq->kickfd, 1);
>> +               eventfd_signal(vq->kickfd);
>>          else
>>                  vq->kicked = true;
>>   unlock:
>> @@ -911,7 +911,7 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
>>                  eventfd_ctx_put(vq->kickfd);
>>          vq->kickfd = ctx;
>>          if (vq->ready && vq->kicked && vq->kickfd) {
>> -               eventfd_signal(vq->kickfd, 1);
>> +               eventfd_signal(vq->kickfd);
>>                  vq->kicked = false;
>>          }
>>          spin_unlock(&vq->kick_lock);
>> @@ -960,7 +960,7 @@ static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
>>
>>          spin_lock_irq(&vq->irq_lock);
>>          if (vq->ready && vq->cb.trigger) {
>> -               eventfd_signal(vq->cb.trigger, 1);
>> +               eventfd_signal(vq->cb.trigger);
>>                  signal = true;
>>          }
>>          spin_unlock_irq(&vq->irq_lock);
>> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
>> index c51229fccbd6..d62fbfff20b8 100644
>> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
>> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
>> @@ -54,7 +54,7 @@ static irqreturn_t vfio_fsl_mc_irq_handler(int irq_num, void *arg)
>>   {
>>          struct vfio_fsl_mc_irq *mc_irq = (struct vfio_fsl_mc_irq *)arg;
>>
>> -       eventfd_signal(mc_irq->trigger, 1);
>> +       eventfd_signal(mc_irq->trigger);
>>          return IRQ_HANDLED;
>>   }
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 1929103ee59a..1cbc990d42e0 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -443,7 +443,7 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>           */
>>          down_write(&vdev->memory_lock);
>>          if (vdev->pm_wake_eventfd_ctx) {
>> -               eventfd_signal(vdev->pm_wake_eventfd_ctx, 1);
>> +               eventfd_signal(vdev->pm_wake_eventfd_ctx);
>>                  __vfio_pci_runtime_pm_exit(vdev);
>>          }
>>          up_write(&vdev->memory_lock);
>> @@ -1883,7 +1883,7 @@ void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count)
>>                          pci_notice_ratelimited(pdev,
>>                                  "Relaying device request to user (#%u)\n",
>>                                  count);
>> -               eventfd_signal(vdev->req_trigger, 1);
>> +               eventfd_signal(vdev->req_trigger);
>>          } else if (count == 0) {
>>                  pci_warn(pdev,
>>                          "No device request channel registered, blocked until released by user\n");
>> @@ -2302,7 +2302,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>>          mutex_lock(&vdev->igate);
>>
>>          if (vdev->err_trigger)
>> -               eventfd_signal(vdev->err_trigger, 1);
>> +               eventfd_signal(vdev->err_trigger);
>>
>>          mutex_unlock(&vdev->igate);
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index cbb4bcbfbf83..237beac83809 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -94,7 +94,7 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
>>                  ctx = vfio_irq_ctx_get(vdev, 0);
>>                  if (WARN_ON_ONCE(!ctx))
>>                          return;
>> -               eventfd_signal(ctx->trigger, 1);
>> +               eventfd_signal(ctx->trigger);
>>          }
>>   }
>>
>> @@ -342,7 +342,7 @@ static irqreturn_t vfio_msihandler(int irq, void *arg)
>>   {
>>          struct eventfd_ctx *trigger = arg;
>>
>> -       eventfd_signal(trigger, 1);
>> +       eventfd_signal(trigger);
>>          return IRQ_HANDLED;
>>   }
>>
>> @@ -689,11 +689,11 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>>                  if (!ctx)
>>                          continue;
>>                  if (flags & VFIO_IRQ_SET_DATA_NONE) {
>> -                       eventfd_signal(ctx->trigger, 1);
>> +                       eventfd_signal(ctx->trigger);
>>                  } else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>>                          uint8_t *bools = data;
>>                          if (bools[i - start])
>> -                               eventfd_signal(ctx->trigger, 1);
>> +                               eventfd_signal(ctx->trigger);
>>                  }
>>          }
>>          return 0;
>> @@ -707,7 +707,7 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
>>          if (flags & VFIO_IRQ_SET_DATA_NONE) {
>>                  if (*ctx) {
>>                          if (count) {
>> -                               eventfd_signal(*ctx, 1);
>> +                               eventfd_signal(*ctx);
>>                          } else {
>>                                  eventfd_ctx_put(*ctx);
>>                                  *ctx = NULL;
>> @@ -722,7 +722,7 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
>>
>>                  trigger = *(uint8_t *)data;
>>                  if (trigger && *ctx)
>> -                       eventfd_signal(*ctx, 1);
>> +                       eventfd_signal(*ctx);
>>
>>                  return 0;
>>          } else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 665197caed89..61a1bfb68ac7 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -155,7 +155,7 @@ static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
>>          spin_unlock_irqrestore(&irq_ctx->lock, flags);
>>
>>          if (ret == IRQ_HANDLED)
>> -               eventfd_signal(irq_ctx->trigger, 1);
>> +               eventfd_signal(irq_ctx->trigger);
>>
>>          return ret;
>>   }
>> @@ -164,7 +164,7 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
>>   {
>>          struct vfio_platform_irq *irq_ctx = dev_id;
>>
>> -       eventfd_signal(irq_ctx->trigger, 1);
>> +       eventfd_signal(irq_ctx->trigger);
>>
>>          return IRQ_HANDLED;
>>   }
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 30df5c58db73..8d9f958946d6 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -178,7 +178,7 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *private)
>>          struct eventfd_ctx *call_ctx = vq->call_ctx.ctx;
>>
>>          if (call_ctx)
>> -               eventfd_signal(call_ctx, 1);
>> +               eventfd_signal(call_ctx);
>>
>>          return IRQ_HANDLED;
>>   }
>> @@ -189,7 +189,7 @@ static irqreturn_t vhost_vdpa_config_cb(void *private)
>>          struct eventfd_ctx *config_ctx = v->config_ctx;
>>
>>          if (config_ctx)
>> -               eventfd_signal(config_ctx, 1);
>> +               eventfd_signal(config_ctx);
>>
>>          return IRQ_HANDLED;
>>   }
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index e0c181ad17e3..045f666b4f12 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2248,7 +2248,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
>>                  len -= l;
>>                  if (!len) {
>>                          if (vq->log_ctx)
>> -                               eventfd_signal(vq->log_ctx, 1);
>> +                               eventfd_signal(vq->log_ctx);
>>                          return 0;
>>                  }
>>          }
>> @@ -2271,7 +2271,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>>                  log_used(vq, (used - (void __user *)vq->used),
>>                           sizeof vq->used->flags);
>>                  if (vq->log_ctx)
>> -                       eventfd_signal(vq->log_ctx, 1);
>> +                       eventfd_signal(vq->log_ctx);
>>          }
>>          return 0;
>>   }
>> @@ -2289,7 +2289,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq)
>>                  log_used(vq, (used - (void __user *)vq->used),
>>                           sizeof *vhost_avail_event(vq));
>>                  if (vq->log_ctx)
>> -                       eventfd_signal(vq->log_ctx, 1);
>> +                       eventfd_signal(vq->log_ctx);
>>          }
>>          return 0;
>>   }
>> @@ -2715,7 +2715,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>>                  log_used(vq, offsetof(struct vring_used, idx),
>>                           sizeof vq->used->idx);
>>                  if (vq->log_ctx)
>> -                       eventfd_signal(vq->log_ctx, 1);
>> +                       eventfd_signal(vq->log_ctx);
>>          }
>>          return r;
>>   }
>> @@ -2763,7 +2763,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   {
>>          /* Signal the Guest tell them we used something up. */
>>          if (vq->call_ctx.ctx && vhost_notify(dev, vq))
>> -               eventfd_signal(vq->call_ctx.ctx, 1);
>> +               eventfd_signal(vq->call_ctx.ctx);
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_signal);
>>
>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>> index f60d5f7bef94..9e942fcda5c3 100644
>> --- a/drivers/vhost/vhost.h
>> +++ b/drivers/vhost/vhost.h
>> @@ -249,7 +249,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>>   #define vq_err(vq, fmt, ...) do {                                  \
>>                  pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
>>                  if ((vq)->error_ctx)                               \
>> -                               eventfd_signal((vq)->error_ctx, 1);\
>> +                               eventfd_signal((vq)->error_ctx);\
>>          } while (0)
>>
>>   enum {
>> diff --git a/drivers/virt/acrn/ioeventfd.c b/drivers/virt/acrn/ioeventfd.c
>> index ac4037e9f947..4e845c6ca0b5 100644
>> --- a/drivers/virt/acrn/ioeventfd.c
>> +++ b/drivers/virt/acrn/ioeventfd.c
>> @@ -223,7 +223,7 @@ static int acrn_ioeventfd_handler(struct acrn_ioreq_client *client,
>>          mutex_lock(&client->vm->ioeventfds_lock);
>>          p = hsm_ioeventfd_match(client->vm, addr, val, size, req->type);
>>          if (p)
>> -               eventfd_signal(p->eventfd, 1);
>> +               eventfd_signal(p->eventfd);
>>          mutex_unlock(&client->vm->ioeventfds_lock);
>>
>>          return 0;
>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>> index 1ce7f3c7a950..7efc0c62e984 100644
>> --- a/drivers/xen/privcmd.c
>> +++ b/drivers/xen/privcmd.c
>> @@ -1147,7 +1147,7 @@ static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
>>                  if (ioreq->addr == kioeventfd->addr + VIRTIO_MMIO_QUEUE_NOTIFY &&
>>                      ioreq->size == kioeventfd->addr_len &&
>>                      (ioreq->data & QUEUE_NOTIFY_VQ_MASK) == kioeventfd->vq) {
>> -                       eventfd_signal(kioeventfd->eventfd, 1);
>> +                       eventfd_signal(kioeventfd->eventfd);
>>                          state = STATE_IORESP_READY;
>>                          break;
>>                  }
>> diff --git a/fs/aio.c b/fs/aio.c
>> index f8589caef9c1..5c5b09e52d75 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1166,7 +1166,7 @@ static void aio_complete(struct aio_kiocb *iocb)
>>           * from IRQ context.
>>           */
>>          if (iocb->ki_eventfd)
>> -               eventfd_signal(iocb->ki_eventfd, 1);
>> +               eventfd_signal(iocb->ki_eventfd);
>>
>>          /*
>>           * We have to order our ring_info tail store above and test
>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>> index 33a918f9566c..dc9e01053235 100644
>> --- a/fs/eventfd.c
>> +++ b/fs/eventfd.c
>> @@ -74,20 +74,17 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
>>   /**
>>    * eventfd_signal - Adds @n to the eventfd counter.
>>    * @ctx: [in] Pointer to the eventfd context.
>> - * @n: [in] Value of the counter to be added to the eventfd internal counter.
>> - *          The value cannot be negative.
>>    *
>>    * This function is supposed to be called by the kernel in paths that do not
>>    * allow sleeping. In this function we allow the counter to reach the ULLONG_MAX
>>    * value, and we signal this as overflow condition by returning a EPOLLERR
>>    * to poll(2).
>>    *
>> - * Returns the amount by which the counter was incremented.  This will be less
>> - * than @n if the counter has overflowed.
>> + * Returns the amount by which the counter was incremented.
>>    */
>> -__u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>> +__u64 eventfd_signal(struct eventfd_ctx *ctx)
>>   {
>> -       return eventfd_signal_mask(ctx, n, 0);
>> +       return eventfd_signal_mask(ctx, 1, 0);
>>   }
>>   EXPORT_SYMBOL_GPL(eventfd_signal);
>>
>> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
>> index b9d83652c097..562089431551 100644
>> --- a/include/linux/eventfd.h
>> +++ b/include/linux/eventfd.h
>> @@ -35,7 +35,7 @@ void eventfd_ctx_put(struct eventfd_ctx *ctx);
>>   struct file *eventfd_fget(int fd);
>>   struct eventfd_ctx *eventfd_ctx_fdget(int fd);
>>   struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
>> -__u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
>> +__u64 eventfd_signal(struct eventfd_ctx *ctx);
>>   __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask);
>>   int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
>>                                    __u64 *cnt);
>> @@ -58,7 +58,7 @@ static inline struct eventfd_ctx *eventfd_ctx_fdget(int fd)
>>          return ERR_PTR(-ENOSYS);
>>   }
>>
>> -static inline int eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>> +static inline int eventfd_signal(struct eventfd_ctx *ctx)
>>   {
>>          return -ENOSYS;
>>   }
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 774bd6e21e27..dfbb1d3b77b7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4378,7 +4378,7 @@ static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
>>           * only one element of the array here.
>>           */
>>          for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
>> -               eventfd_signal(t->entries[i].eventfd, 1);
>> +               eventfd_signal(t->entries[i].eventfd);
>>
>>          /* i = current_threshold + 1 */
>>          i++;
>> @@ -4390,7 +4390,7 @@ static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
>>           * only one element of the array here.
>>           */
>>          for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
>> -               eventfd_signal(t->entries[i].eventfd, 1);
>> +               eventfd_signal(t->entries[i].eventfd);
>>
>>          /* Update current_threshold */
>>          t->current_threshold = i - 1;
>> @@ -4430,7 +4430,7 @@ static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
>>          spin_lock(&memcg_oom_lock);
>>
>>          list_for_each_entry(ev, &memcg->oom_notify, list)
>> -               eventfd_signal(ev->eventfd, 1);
>> +               eventfd_signal(ev->eventfd);
>>
>>          spin_unlock(&memcg_oom_lock);
>>          return 0;
>> @@ -4649,7 +4649,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
>>
>>          /* already in OOM ? */
>>          if (memcg->under_oom)
>> -               eventfd_signal(eventfd, 1);
>> +               eventfd_signal(eventfd);
>>          spin_unlock(&memcg_oom_lock);
>>
>>          return 0;
>> @@ -4941,7 +4941,7 @@ static void memcg_event_remove(struct work_struct *work)
>>          event->unregister_event(memcg, event->eventfd);
>>
>>          /* Notify userspace the event is going away. */
>> -       eventfd_signal(event->eventfd, 1);
>> +       eventfd_signal(event->eventfd);
>>
>>          eventfd_ctx_put(event->eventfd);
>>          kfree(event);
>> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>> index 22c6689d9302..bd5183dfd879 100644
>> --- a/mm/vmpressure.c
>> +++ b/mm/vmpressure.c
>> @@ -169,7 +169,7 @@ static bool vmpressure_event(struct vmpressure *vmpr,
>>                          continue;
>>                  if (level < ev->level)
>>                          continue;
>> -               eventfd_signal(ev->efd, 1);
>> +               eventfd_signal(ev->efd);
>>                  ret = true;
>>          }
>>          mutex_unlock(&vmpr->events_lock);
>> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
>> index 69ba0281f9e0..2284b3751240 100644
>> --- a/samples/vfio-mdev/mtty.c
>> +++ b/samples/vfio-mdev/mtty.c
>> @@ -234,10 +234,10 @@ static void mtty_trigger_interrupt(struct mdev_state *mdev_state)
>>
>>          if (is_msi(mdev_state)) {
>>                  if (mdev_state->msi_evtfd)
>> -                       eventfd_signal(mdev_state->msi_evtfd, 1);
>> +                       eventfd_signal(mdev_state->msi_evtfd);
>>          } else if (is_intx(mdev_state)) {
>>                  if (mdev_state->intx_evtfd && !mdev_state->intx_mask) {
>> -                       eventfd_signal(mdev_state->intx_evtfd, 1);
>> +                       eventfd_signal(mdev_state->intx_evtfd);
>>                          mdev_state->intx_mask = true;
>>                  }
>>          }
>> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
>> index 89912a17f5d5..c0e230f4c3e9 100644
>> --- a/virt/kvm/eventfd.c
>> +++ b/virt/kvm/eventfd.c
>> @@ -61,7 +61,7 @@ static void irqfd_resampler_notify(struct kvm_kernel_irqfd_resampler *resampler)
>>
>>          list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
>>                                   srcu_read_lock_held(&resampler->kvm->irq_srcu))
>> -               eventfd_signal(irqfd->resamplefd, 1);
>> +               eventfd_signal(irqfd->resamplefd);
>>   }
>>
>>   /*
>> @@ -786,7 +786,7 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this, gpa_t addr,
>>          if (!ioeventfd_in_range(p, addr, len, val))
>>                  return -EOPNOTSUPP;
>>
>> -       eventfd_signal(p->eventfd, 1);
>> +       eventfd_signal(p->eventfd);
>>          return 0;
>>   }
>>
>>
>> --
>> 2.42.0
>>
>>

