Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7961505D
	for <lists+linux-s390@lfdr.de>; Mon,  6 May 2019 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEFPhN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 May 2019 11:37:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEFPhN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 6 May 2019 11:37:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4B2E3060350;
        Mon,  6 May 2019 15:37:12 +0000 (UTC)
Received: from gondolin (unknown [10.40.205.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209B653E2C;
        Mon,  6 May 2019 15:37:10 +0000 (UTC)
Date:   Mon, 6 May 2019 17:37:07 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
Message-ID: <20190506173707.40216e76.cohuck@redhat.com>
In-Reply-To: <20190503134912.39756-8-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-8-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 06 May 2019 15:37:12 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  3 May 2019 15:49:12 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> If the CCW being processed is a No-Operation, then by definition no
> data is being transferred.  Let's fold those checks into the normal
> CCW processors, rather than skipping out early.
> 
> Likewise, if the CCW being processed is a "test" (an invented
> definition to simply mean it ends in a zero), 

The "Common I/O Device Commands" document actually defines this :)

> let's permit that to go
> through to the hardware.  There's nothing inherently unique about
> those command codes versus one that ends in an eight [1], or any other
> otherwise valid command codes that are undefined for the device type
> in question.

But I agree that everything possible should be sent to the hardware.

> 
> [1] POPS states that a x08 is a TIC CCW, and that having any high-order
> bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
> high-order bits are ignored.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 36d76b821209..c0a52025bf06 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -289,8 +289,6 @@ static long copy_ccw_from_iova(struct channel_program *cp,
>  #define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 0x0C)
>  #define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == CCW_CMD_BASIC_SENSE)
>  
> -#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
> -
>  #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
>  
>  #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
> @@ -314,6 +312,10 @@ static inline int ccw_does_data_transfer(struct ccw1 *ccw)
>  	if (ccw->count == 0)
>  		return 0;
>  
> +	/* If the command is a NOP, then no data will be transferred */
> +	if (ccw_is_noop(ccw))
> +		return 0;
> +

Don't you need to return 0 here for any test command as well?

(If I read the doc correctly, we'll just get a unit check in any case,
as there are no parallel I/O interfaces on modern s390 boxes. Even if
we had a parallel I/O interface, we'd just collect the status, and not
get any data transfer. FWIW, the QEMU ccw interpreter for emulated
devices rejects test ccws with a channel program check, which looks
wrong; should be a command reject instead.)

>  	/* If the skip flag is off, then data will be transferred */
>  	if (!ccw_is_skip(ccw))
>  		return 1;
> @@ -398,7 +400,7 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>  {
>  	struct ccw1 *ccw = chain->ch_ccw + idx;
>  
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
> +	if (ccw_is_tic(ccw))
>  		return;
>  
>  	kfree((void *)(u64)ccw->cda);
> @@ -723,9 +725,6 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>  {
>  	struct ccw1 *ccw = chain->ch_ccw + idx;
>  
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
> -		return 0;
> -
>  	if (ccw_is_tic(ccw))
>  		return ccwchain_fetch_tic(chain, idx, cp);
>  

