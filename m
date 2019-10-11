Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FAD3773
	for <lists+linux-s390@lfdr.de>; Fri, 11 Oct 2019 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfJKCRL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 22:17:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39386 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfJKCRK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 22:17:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so11719289qtb.6
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 19:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hkxzZutoMB4mL+d3Ug//lWHvkUJxUQSMy0n0jqoKL1M=;
        b=wTT3aAagQKQtlbtIxC5nKSFwQb7PwbfsDSTqjSB2TLJcRyFrZrHmOaNsDcT1oOQqKG
         KZrtSQV7XGijBUVPpP/0TRkP4SWIRyhWDR2vJBw1H0IYzvsHC/fDu5a2FfbAdUfLJIKX
         Nr2IATVQ0z27V0O6hCb5xgK81jPANhyzh7NeTVdD3aaBk5Im18822Fepc3bXbm/5SUVR
         ioTIVJn3wMmcWTlorKTAByvus/VqTwGzMha1bMw4fCqxvToLTzf7t26KGFn8z+SUhlmf
         //9wLyU3uMdnFjxZ1ZLn9TwUX5euyqkB5x03SLYEk2aHcU6xH9mFjMDieQZRaJid6hEp
         3GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hkxzZutoMB4mL+d3Ug//lWHvkUJxUQSMy0n0jqoKL1M=;
        b=GPpdoRcxq9LfsW1EkN4otGlDqe9M2a+55tfHFM051EtCM4mx56QnnQoUpJ1EBqgavs
         KPJ4KjDwJ4splrGlbjK3s2QYeeu7Y/psmInof1NiJ8QL/OGCJo7beC7mLvtrSBQlkz0+
         zppBNudL3WHnw5HiPWoL6v9/kkSKMujShQrlHSXhlvECG/kcQ50iF2ZvVDq7idLUCeUH
         u6ryPAyMrzN0Bxa4fl7QZ0YFm4EMVJXF9KWFHLjw5BrdL7PmbqZ6Vd8tG0MGaawOTqaZ
         PWjkt+Xo71BinmhZiS0wd4gZwNDCwp+oOkNSNeXaKc1zWxl13HGfWejRvQC8L4eshix+
         /TqA==
X-Gm-Message-State: APjAAAXKoDUlaTVhScuS4iElDWA7MOZQDPfkb45cgoASEbkoeONwKbJk
        +5kgad2Um0OCcFRdwzR/wPxLAw==
X-Google-Smtp-Source: APXvYqzIn0S9ummLC74r3g9FqMdFkhi41XU2tWER3IiwCUIpjHJ14Oj4RC+eYohu8iGTOxdjyDbTYQ==
X-Received: by 2002:ac8:d04:: with SMTP id q4mr13985060qti.76.1570760229973;
        Thu, 10 Oct 2019 19:17:09 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m63sm3564290qkc.72.2019.10.10.19.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 19:17:09 -0700 (PDT)
Date:   Thu, 10 Oct 2019 19:16:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: Re: [PATCH v2 net 0/3] net/smc: fixes for -net
Message-ID: <20191010191653.35c93381@cakuba.netronome.com>
In-Reply-To: <20191010081611.35446-1-kgraul@linux.ibm.com>
References: <20191010081611.35446-1-kgraul@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 10 Oct 2019 10:16:08 +0200, Karsten Graul wrote:
> Fixes for -net, addressing two races in SMC receive path and
> add a missing cleanup when the link group creating fails with
> ISM devices and a VLAN id.
> 
> v1->v2:
> - added fixes tags

Applied, queued for stable
