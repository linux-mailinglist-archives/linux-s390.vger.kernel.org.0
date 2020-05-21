Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C701DCF93
	for <lists+linux-s390@lfdr.de>; Thu, 21 May 2020 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEUOWw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 21 May 2020 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgEUOWv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 May 2020 10:22:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275ABC05BD43
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2020 07:22:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so3386667pfu.5
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2020 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7NAmzzUc8RDa1YR+Eq9Z8360Zk80yZKFG2PLDO4/2Y=;
        b=tOa660Sal8OXd6c8NS5AgZ9HeKtz8Jv5WPVotHSp2YsZf3PVefhU8fzM8DEDYsZhuH
         nwuAFcnA+g7leW1cqgCuPZx1Jb//VcgfHCFhySyfl7LZ5xzWdMsh5j3s/HJsXvCjuapp
         +sMk2l/5cGtckSthqHBmf3QiLlrzjEjNTigiEucC1nexFzG+826wt71G3ACmjsKT/DPI
         Yk2Ox/1LT/JW6zwBK3REoGuO0fa5AOW3UT9i0IAyEW1wrXl+fc3BX2mTTVbd5kP3nEnI
         MUghQk+YUSwcR+oYbhBzqxhe/eFrPTa6b9iCiHI6glok/XzlYAIqnZ6dubdgVxIbDJP5
         n5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7NAmzzUc8RDa1YR+Eq9Z8360Zk80yZKFG2PLDO4/2Y=;
        b=KBRyVJLVl9jxxM6CrU19AxeqfXNmaEyu244xJsTz/MGqnAWq8j8C4ijP0A3ql4HWlv
         6JKgbRV7D45No2KIbGvkNwxOApeXL7EnCE0A0iIw7U+AUw/i5sFooAILxODtftnwEUV4
         fnozsqxQFhIiQjJ0RfCluSS+lPnZ7OVG3cfABNWrRRYRfapJX14NBdDAG5ihFqhXqY5U
         6fEzN3Myc9E/PnhhXQl7+8nr3OE7t0ljbH6XtftWqYHSJUVInDwFzhbqIUr48OgplgsK
         fVYn4W/f3T6rmwEvEEV3x3PQ+6Ggp1C7TCbzEsOaQc8RbMLYfruaLPTumAwOlN/ann7O
         LoJQ==
X-Gm-Message-State: AOAM530cOTFtyPBO97xmRS0YVBxwPWFSqzw8C4t3ltLOiIYZna/FxL9j
        INGN8GVh7tZ1EuFUbTzn5Kvssw==
X-Google-Smtp-Source: ABdhPJyJQGM+MKPAkV3f/A18aisCcPUcbgswhybfF5O3QJZiA9lrxr/E7NpvDRwWHHsS5tRvp5L4jQ==
X-Received: by 2002:a62:e10e:: with SMTP id q14mr6844993pfh.88.1590070970562;
        Thu, 21 May 2020 07:22:50 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c00a:8fd2:4246:efbe? ([2605:e000:100e:8c61:c00a:8fd2:4246:efbe])
        by smtp.gmail.com with ESMTPSA id i66sm4175229pfe.135.2020.05.21.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:22:49 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] s390/dasd: remove ioctl_by_bdev from DASD driver
To:     Stefan Haberland <sth@linux.ibm.com>, hch@lst.de
Cc:     hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com
References: <20200519142259.102279-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3889844e-20eb-6b33-6bbd-109d11b0a71e@kernel.dk>
Date:   Thu, 21 May 2020 08:22:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519142259.102279-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/19/20 8:22 AM, Stefan Haberland wrote:
> Hi Christoph,
> 
> here are the patches again. Reviewed and tested internally with DASD as
> well as DASD labeled virtblk devices.
> So if you agree with the two patches I have no objection against an
> inclusion.

Applied for 5.8, with Christoph's removal patch as well.

-- 
Jens Axboe

