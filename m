Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45687EA213
	for <lists+linux-s390@lfdr.de>; Wed, 30 Oct 2019 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfJ3QvS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 30 Oct 2019 12:51:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbfJ3QvR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 12:51:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9UGdJvM036592;
        Wed, 30 Oct 2019 12:51:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vydy6hcxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 12:51:16 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9UGdhCx038409;
        Wed, 30 Oct 2019 12:51:15 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vydy6hcwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 12:51:15 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9UGp6Sl004993;
        Wed, 30 Oct 2019 16:51:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2vxwh8hacr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 16:51:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9UGpC1Z37749230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:51:12 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5072428058;
        Wed, 30 Oct 2019 16:51:12 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DBA92805A;
        Wed, 30 Oct 2019 16:51:11 +0000 (GMT)
Received: from [9.80.239.220] (unknown [9.80.239.220])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Oct 2019 16:51:11 +0000 (GMT)
Subject: Re: [PATCH] s390: vfio-ap: disable IRQ in remove callback results in
 kernel OOPS
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, jjherne@linux.ibm.com
References: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
 <0565c250-726f-dd99-f933-f91162dc107e@linux.ibm.com>
 <97cf7863-d6d0-418a-09c1-50d9e84fd855@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <2ea83094-46c6-ef92-f39c-579f88979320@linux.ibm.com>
Date:   Wed, 30 Oct 2019 12:51:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <97cf7863-d6d0-418a-09c1-50d9e84fd855@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300150
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/30/19 10:00 AM, Pierre Morel wrote:
> 
> 
> 
> On 10/30/19 8:44 AM, Harald Freudenberger wrote:
>> On 29.10.19 23:09, Tony Krowiak wrote:
>>> From: aekrowia <akrowiak@linux.ibm.com>
>>>
>>> When an AP adapter card is configured off via the SE or the SCLP
>>> Deconfigure Adjunct Processor command and the AP bus subsequently 
>>> detects
>>> that the adapter card is no longer in the AP configuration, the card
>>> device representing the adapter card as well as each of its associated
>>> AP queue devices will be removed by the AP bus. If one or more of the
>>> affected queue devices is bound to the VFIO AP device driver, its remove
>>> callback will be invoked for each queue to be removed. The remove 
>>> callback
>>> resets the queue and disables IRQ processing. If interrupt processing 
>>> was
>>> never enabled for the queue, disabling IRQ processing will fail 
>>> resulting
>>> in a kernel OOPS.
>>>
>>> This patch verifies IRQ processing is enabled before attempting to 
>>> disable
>>> interrupts for the queue.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Signed-off-by: aekrowia <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>> index be2520cc010b..42d8308fd3a1 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -79,7 +79,8 @@ static void vfio_ap_queue_dev_remove(struct 
>>> ap_device *apdev)
>>>       apid = AP_QID_CARD(q->apqn);
>>>       apqi = AP_QID_QUEUE(q->apqn);
>>>       vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>> -    vfio_ap_irq_disable(q);
>>> +    if (q->saved_isc != VFIO_AP_ISC_INVALID)
>>> +        vfio_ap_irq_disable(q);
>>>       kfree(q);
>>>       mutex_unlock(&matrix_dev->lock);
>>>   }
>> Reset of an APQN does also clear IRQ processing. I don't say that the
>> resources associated with IRQ handling for the APQN are also cleared.
>> But when you call PQAP(AQIC) after an PQAP(RAPQ) or PQAP(ZAPQ)
>> it is superfluous. However, there should not appear any kernel OOPS.
>> So can you please give me more details about this kernel oops - maybe
>> I need to add exception handler code to the inline ap_aqic() function.
>>
>> regards, Harald Freudenberger
>>
> 
> Hi Tony,
> 
> wasn't it already solved by the patch 5c4c2126  from Christian ?

No, that patch merely sets the 'matrix_mdev' field of the
'struct vfio_ap_queue' to NULL in the vfio_ap_free_aqic_resources()
function. Also, with the latest master branch which has 5c4c2126
installed, the failure occurs.

> 
> Can you send the trace to me please?

[  266.989476] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=B, 
anc=0, erc=0, rsid=0
[  266.989617] ------------[ cut here ]------------
[  266.989622] vfio_ap_wait_for_irqclear: tapq rc 03: 0504
[  266.989681] WARNING: CPU: 0 PID: 7 at 
drivers/s390/crypto/vfio_ap_ops.c:101 vfio_ap_irq_disable+0x13c/0x1b0 
[vfio_ap]
[  266.989682] Modules linked in: xt_CHECKSUM xt_MASQUERADE tun bridge 
stp llc ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack 
ebtable_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security 
iptable_nat nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables sunrpc ghash_s390 
prng aes_s390 des_s390 libdes vfio_ccw sha512_s390 sha1_s390 eadm_sch 
zcrypt_cex4 qeth_l2 crc32_vx_s390 dasd_eckd_mod sha256_s390 qeth 
sha_common dasd_mod ccwgroup qdio pkey zcrypt vfio_ap kvm
[  266.989704] CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.4.0-rc5 #81
[  266.989705] Hardware name: IBM 2964 NE1 749 (LPAR)
[  266.989710] Workqueue: events_long ap_scan_bus
[  266.989711] Krnl PSW : 0704c00180000000 000003ff8007d89c 
(vfio_ap_irq_disable+0x13c/0x1b0 [vfio_ap])
[  266.989714]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 
PM:0 RI:0 EA:3
[  266.989716] Krnl GPRS: 000000000000000a 0000000000000006 
000000000000002b 0000000000000007
[  266.989717]            0000000000000007 000000007fe06000 
000003ff00000005 0000000000000000
[  266.989718]            0000000100000504 0000000000000003 
00000001f9d27e40 000003e00003bb5c
[  266.989719]            00000001fe765d00 0000000000000504 
000003ff8007d898 000003e00003ba60
[  266.989724] Krnl Code: 000003ff8007d88c: c02000000ce6    larl 
%r2,3ff8007f258
                           000003ff8007d892: c0e5fffff4c7    brasl 
%r14,3ff8007c220
                          #000003ff8007d898: a7f40001        brc 
15,3ff8007d89a
                          >000003ff8007d89c: a7f4ff9d        brc 
15,3ff8007d7d6
                           000003ff8007d8a0: a7100100        tmlh    %r1,256
                           000003ff8007d8a4: a784ff99        brc 
8,3ff8007d7d6
                           000003ff8007d8a8: a7290014        lghi    %r2,20
                           000003ff8007d8ac: c0e5fffff4b0    brasl 
%r14,3ff8007c20c
[  266.989772] Call Trace:
[  266.989777] ([<000003ff8007d898>] vfio_ap_irq_disable+0x138/0x1b0 
[vfio_ap])
[  266.989779]  [<000003ff8007c4d2>] vfio_ap_queue_dev_remove+0x6a/0x90 
[vfio_ap]
[  266.989782]  [<00000000bf0f24f0>] ap_device_remove+0x50/0x110
[  266.989784]  [<00000000beffbaac>] 
device_release_driver_internal+0x114/0x1f0
[  266.989787]  [<00000000beff9c88>] bus_remove_device+0x108/0x190
[  266.989789]  [<00000000beff5418>] device_del+0x178/0x3a0
[  266.989790]  [<00000000beff5670>] device_unregister+0x30/0x90
[  266.989791]  [<00000000bf0f0f04>] 
__ap_queue_devices_with_id_unregister+0x44/0x50
[  266.989793]  [<00000000beff86ea>] bus_for_each_dev+0x82/0xb0
[  266.989794]  [<00000000bf0f2aba>] ap_scan_bus+0x262/0x878
[  266.989798]  [<00000000beb4785c>] process_one_work+0x1e4/0x410
[  266.989800]  [<00000000beb47ca8>] worker_thread+0x220/0x460
[  266.989802]  [<00000000beb4e99a>] kthread+0x12a/0x160
[  266.989805]  [<00000000bf2d8eb0>] ret_from_fork+0x28/0x2c
[  266.989806]  [<00000000bf2d8eb4>] kernel_thread_starter+0x0/0xc
[  266.989807] Last Breaking-Event-Address:
[  266.989809]  [<000003ff8007d898>] vfio_ap_irq_disable+0x138/0x1b0 
[vfio_ap]
[  266.989810] ---[ end trace 59b4020890dbd391 ]---


> 
> Thanks,
> 
> Pierre
> 
> 
> 

