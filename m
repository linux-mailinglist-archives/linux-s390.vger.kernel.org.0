Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864CC2FD74A
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jan 2021 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbhATRg3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Jan 2021 12:36:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48442 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730353AbhATR3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 12:29:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KH4L4X066298;
        Wed, 20 Jan 2021 12:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fkYQ5QEnvEnz+Waq4hKQZ3CzKo6Jjb7PSHZKSJ+BtSw=;
 b=l8DjEB161xVzkfEFWK10SWOXlC2Uffwf+dHUZwFBv9lTvyTbCBGMKaGKarHtmJlIHsVs
 d/45cJJ0U3geiXF4rh+FyCsWsK7pilMxlmOt2RHnfkQ5uQIdvgFQF8t9auoTnW1d0goC
 2Az0XXBXiuQ66mhP3P2PZzEbsFg+Wm4uMCsrYFo0I/8MCSKReWnxl7QIJcW7ABeqVees
 PtTztXkaJntJjl4PksfJL2VT8jDsQOVTToRzhN1BVeVQyoJSOu+6OBlmBbl510WZR3LA
 uFYjlnTxZWDQw2++xXiE3QCDRMfl1GbJR0rLg6QIgii5cjXv+x0Ye+GwEIjB6mL1kL1G xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366nn0q9qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 12:28:28 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10KH5Hto071447;
        Wed, 20 Jan 2021 12:28:27 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366nn0q9qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 12:28:27 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KHN0mE010078;
        Wed, 20 Jan 2021 17:28:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3668nwrvjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 17:28:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KHSMLJ43188732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 17:28:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4791A4055;
        Wed, 20 Jan 2021 17:28:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51637A404D;
        Wed, 20 Jan 2021 17:28:22 +0000 (GMT)
Received: from [9.145.95.250] (unknown [9.145.95.250])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 17:28:22 +0000 (GMT)
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        alex.williamson@redhat.com, cohuck@redhat.com
Cc:     pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
 <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
 <90d99da8-02cf-e051-314b-2ab192f8fd57@linux.ibm.com>
 <e26c2616-69cf-78f3-81db-972a0d461bc9@linux.ibm.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <bf7728b6-3c6d-5b71-8a4d-fc55b0013d9a@linux.ibm.com>
Date:   Wed, 20 Jan 2021 18:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e26c2616-69cf-78f3-81db-972a0d461bc9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_10:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/20/21 6:10 PM, Matthew Rosato wrote:
> On 1/20/21 8:21 AM, Niklas Schnelle wrote:
>>
>>
>> On 1/19/21 9:02 PM, Matthew Rosato wrote:
>>> Some s390 PCI devices (e.g. ISM) perform I/O operations that have very
>> .. snip ...
>>> +
>>> +static size_t vfio_pci_zdev_io_rw(struct vfio_pci_device *vdev,
>>> +                  char __user *buf, size_t count,
>>> +                  loff_t *ppos, bool iswrite)
>>> +{
>> ... snip ...
>>> +    /*
>>> +     * For now, the largest allowed block I/O is advertised as PAGE_SIZE,
>>> +     * and cannot exceed a page boundary - so a single page is enough.  The
>>> +     * guest should have validated this but let's double-check that the
>>> +     * request will not cross a page boundary.
>>> +     */
>>> +    if (((region->req.gaddr & ~PAGE_MASK)
>>> +            + region->req.len - 1) & PAGE_MASK) {
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    mutex_lock(&zdev->lock);
>>
>> I plan on using the zdev->lock for preventing concurrent zPCI devices
>> removal/configuration state changes between zPCI availability/error
>> events and enable_slot()/disable_slot() and /sys/bus/pci/devices/<dev>/recover.
>>
>> With that use in place using it here causes a deadlock when doing
>> "echo 0 > /sys/bus/pci/slots/<fid>/power from the host for an ISM device
>> attached to a guest.
>>
>> This is because the (soft) hot unplug will cause vfio to notify QEMU, which
>> sends a deconfiguration request to the guest, which then tries to
>> gracefully shutdown the device. During that shutdown the device will
>> be accessed, running into this code path which then blocks on
>> the lock held by the disable_slot() code which waits on vfio
>> releasing the device.
>>
> 
> Oof, good catch.  The primary purpose of acquiring the zdev lock here was to ensure that the region is only being used to process one operation at a time and at the time I wrote this initially the zdev lock seemed like a reasonable candidate :)

Oh ok, I thought it was to guard against removal. What's the reason
we can't have multiple concurrent users of the region though?
The PCISTB/PCILG should be able to be executed concurrently but
I'm probably missing something.

> 
>> Alex may correct me if I'm wrong but I think instead vfio should
>> be holding the PCI device lock via pci_device_lock(pdev).
>>
> 
> OK, I can have a look at this.  Thanks.

Hmm, ok that idea was based on my assumption that it guards
against removal. My bad, of course without my patch it wouldn't
and this came before..

> 
> 
>> The annotated trace with my test code looks as follows:
>>
>> [  618.025091] Call Trace:
>> [  618.025093]  [<00000007c1a139e0>] __schedule+0x360/0x960
>> [  618.025104]  [<00000007c1a14760>] schedule_preempt_disabled+0x60/0x100
>> [  618.025107]  [<00000007c1a16b48>] __mutex_lock+0x358/0x880
>> [  618.025110]  [<00000007c1a170a2>] mutex_lock_nested+0x32/0x40
>> [  618.025112]  [<000003ff805a3948>] vfio_pci_zdev_io_rw+0x168/0x310 [vfio_pci]
>> [  618.025120]  [<000003ff8059b2b0>] vfio_pci_write+0xd0/0xe0 [vfio_pci]
>> [  618.025124]  [<00000007c0fa5392>] __s390x_sys_pwrite64+0x112/0x360
>> [  618.025129]  [<00000007c1a0aaf6>] __do_syscall+0x116/0x190
>> [  618.025132]  [<00000007c1a1deda>] system_call+0x72/0x98
>> [  618.025137] 1 lock held by qemu-system-s39/1315:
>> [  618.025139]  #0: 000000008524b4e8 (&zdev->lock){....}-{3:3}, at: vfio_pci_zdev_io_rw+0x168/0x310 [vfio_pci]
>> [  618.025151]
>>                 Showing all locks held in the system:
>> [  618.025166] 1 lock held by khungtaskd/99:
>> [  618.025168]  #0: 00000007c1ed4748 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.0+0x0/0x210
>> [  618.025194] 6 locks held by zsh/1190:
>> [  618.025196]  #0: 0000000095fc0488 (sb_writers#3){....}-{0:0}, at: __do_syscall+0x116/0x190
>> [  618.025226]  #1: 00000000975bf090 (&of->mutex){....}-{3:3}, at: kernfs_fop_write+0x9a/0x240
>> [  618.025236]  #2: 000000008584be78 (kn->active#245){....}-{0:0}, at: kernfs_fop_write+0xa6/0x240
>> [  618.025243]  #3: 000000008524b4e8 (&zdev->lock){....}-{3:3}, at: disable_slot+0x32/0x130 <-------------------------------------|
>> [  618.025252]  #4: 00000007c1f53468 (pci_rescan_remove_lock){....}-{3:3}, at: pci_stop_and_remove_bus_device_locked+0x26/0x240   |
>> [  618.025260]  #5: 0000000085d8a1a0 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x32/0x1d0                              |
>> [  618.025271] 1 lock held by qemu-system-s39/1312:                                                                               D
>> [  618.025273] 1 lock held by qemu-system-s39/1313:                                                                               E
>> [  618.025275]  #0: 00000000d47e80d0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x90/0x780 [kvm]                              A
>> [  618.025322] 1 lock held by qemu-system-s39/1314:                                                                               D
>> [  618.025324]  #0: 00000000d34700d0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x90/0x780 [kvm]                              |
>> [  618.025345] 1 lock held by qemu-system-s39/1315:                                                                               |
>> [  618.025347]  #0: 000000008524b4e8 (&zdev->lock){....}-{3:3}, at: vfio_pci_zdev_io_rw+0x168/0x310 [vfio_pci] <------------------|
>> [  618.025355] 1 lock held by qemu-system-s39/1317:
>> [  618.025357]  #0: 00000000d34480d0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x90/0x780 [kvm]
>> [  618.025378] 1 lock held by qemu-system-s39/1318:
>> [  618.025380]  #0: 00000000d34380d0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x90/0x780 [kvm]
>> [  618.025400] 1 lock held by qemu-system-s39/1319:
>> [  618.025403]  #0: 00000000d47e8a90 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x90/0x780 [kvm]
>> [  618.025424] 2 locks held by zsh/1391:
>> [  618.025426]  #0: 00000000d4a708a0 (&tty->ldisc_sem){....}-{0:0}, at: tty_ldisc_ref_wait+0x34/0x70
>> [  618.025435]  #1: 0000038002fc72f0 (&ldata->atomic_read_lock){....}-{3:3}, at: n_tty_read+0xc8/0xa50
>>
>>
>>> +
>>> +    ret = get_user_pages_fast(region->req.gaddr & PAGE_MASK, 1, 0, &gpage);
>>> +    if (ret <= 0) {
>>> +        count = -EIO;
>> ... snip ...
>>
> 
