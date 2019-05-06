Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC01D14A5D
	for <lists+linux-s390@lfdr.de>; Mon,  6 May 2019 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfEFM4U (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 May 2019 08:56:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbfEFM4U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 May 2019 08:56:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46ClAx0173742
        for <linux-s390@vger.kernel.org>; Mon, 6 May 2019 08:56:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2san5d8hsv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 May 2019 08:56:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 6 May 2019 13:56:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 13:56:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46CuCTN60096576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 12:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF1852050;
        Mon,  6 May 2019 12:56:12 +0000 (GMT)
Received: from [9.145.46.119] (unknown [9.145.46.119])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B4035204E;
        Mon,  6 May 2019 12:56:12 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
To:     Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Farhan Ali <alifm@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190503134912.39756-1-farman@linux.ibm.com>
 <20190503134912.39756-8-farman@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 6 May 2019 14:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503134912.39756-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050612-0012-0000-0000-00000318D196
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050612-0013-0000-0000-000021514AA2
Message-Id: <8625f759-0a2d-09af-c8b5-5b312d854ba1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/05/2019 15:49, Eric Farman wrote:
> If the CCW being processed is a No-Operation, then by definition no
> data is being transferred.  Let's fold those checks into the normal
> CCW processors, rather than skipping out early.
> 
> Likewise, if the CCW being processed is a "test" (an invented
> definition to simply mean it ends in a zero), let's permit that to go
> through to the hardware.  There's nothing inherently unique about
> those command codes versus one that ends in an eight [1], or any other
> otherwise valid command codes that are undefined for the device type
> in question.
> 
> [1] POPS states that a x08 is a TIC CCW, and that having any high-order
> bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
> high-order bits are ignored.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 36d76b821209..c0a52025bf06 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -289,8 +289,6 @@ static long copy_ccw_from_iova(struct channel_program *cp,
>   #define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 0x0C)
>   #define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == CCW_CMD_BASIC_SENSE)
>   
> -#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
> -
>   #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
>   
>   #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
> @@ -314,6 +312,10 @@ static inline int ccw_does_data_transfer(struct ccw1 *ccw)
>   	if (ccw->count == 0)
>   		return 0;
>   
> +	/* If the command is a NOP, then no data will be transferred */
> +	if (ccw_is_noop(ccw))
> +		return 0;
> +
>   	/* If the skip flag is off, then data will be transferred */
>   	if (!ccw_is_skip(ccw))
>   		return 1;
> @@ -398,7 +400,7 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>   {
>   	struct ccw1 *ccw = chain->ch_ccw + idx;
>   
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
> +	if (ccw_is_tic(ccw))


AFAIR, we introduced this code to protect against noop and test with a 
non zero CDA.
This could go away only if there is somewhere the guaranty that noop 
have always a null CDA (same for test).



>   		return;
>   
>   	kfree((void *)(u64)ccw->cda);
> @@ -723,9 +725,6 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>   {
>   	struct ccw1 *ccw = chain->ch_ccw + idx;
>   
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
> -		return 0;
> -
>   	if (ccw_is_tic(ccw))
>   		return ccwchain_fetch_tic(chain, idx, cp);
>   
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

